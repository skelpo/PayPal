import XCTest
import Vapor
@testable import PayPal

final class PaymentsTests: XCTestCase {
    
    var id: String!
    var app: Application!
    var context: PaymentTestsContext!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        self.app = try! Application.testable(services: services)
        self.context = try! PaymentTestsContext.initialize(on: self.app)
        self.id = self.context.payment
    }
    
    func testServiceExists()throws {
        _ = try app.make(Payments.self)
    }
    
    func testCreateEndpoint()throws {
        let payment = try Payment(
            intent: .sale,
            payer: PaymentPayer(method: .paypal, funding: nil, info: nil),
            context: nil,
            transactions: [self.context.transaction],
            experience: nil,
            payerNote: "Thanks for ordering!",
            redirects: Redirects(return: "https://example.com/approved", cancel: "https://example.com/canceled")
        )
        let payments = try self.app.make(Payments.self)
        
        let result = try payments.create(payment: payment).wait()
        
        XCTAssertNotNil(result.id)
        XCTAssertEqual(result.state, .created)
    }
    
    func testListEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        let yesturday = Date() - (60 * 60 * 24)
        let parameters = QueryParamaters(count: 15, startTime: yesturday, page: 0, sortBy: "create_time", sortOrder: .descending)
        
        let list = try payments.list(parameters: parameters).wait()
        
        XCTAssertEqual(list.count, 15)
        XCTAssertLessThanOrEqual(list.payments?.count ?? 0, 15)
        
        if list.payments?.count ?? 0 > 1 {
            let now = Date()
            let sorted = list.payments?.sorted { first, second in
                return (Date(iso8601: first.created ?? now.iso8601) ?? now > Date(iso8601: second.created ?? now.iso8601) ?? now)
            }
            XCTAssertEqual(sorted, list.payments)
        }
    }
    
    func testPatchEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        let patches = try [ Patch(operation: .replace, path: "note_to_payer", value: "Come Again!") ]
        
        let updated = try payments.patch(payment: self.id, with: patches).wait()
        
        XCTAssertEqual(updated.id, self.id)
        XCTAssertEqual(updated.payerNote, "Come Again!")
    }
    
    func testGetEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        let details = try payments.get(payment: self.id).wait()
        
        XCTAssertEqual(details.id, self.id)
    }
    
    func testExecuteEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        let amounts = try [
            DetailedAmount(currency: .usd, total: "152.38", details: nil)
        ]
        
        let details = try payments.execute(payment: self.id, with: Payment.Executor(payer: nil, amounts: amounts)).wait()
        
        XCTAssertEqual(details.id, self.id)
    }
    
    func testGetSaleEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        guard let id = self.context.sale else {
            throw Abort(.internalServerError, reason: "Cannot get sale ID")
        }
        
        let details = try payments.get(sale: id).wait()
        XCTAssertEqual(details.id, id)
    }
    
    func testRefundSaleEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        guard let id = self.context.sale else {
            throw Abort(.internalServerError, reason: "Cannot get sale ID")
        }
        let refund = try Payment.Refund(amount: nil, description: "A description of the refund", reason: "NOT_AS_MARKETED", invoice: nil)
        
        let result = try payments.refund(sale: id, with: refund).wait()
        
        XCTAssertNotNil(result.id)
    }
    
    func testGetAuthorizationEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        guard let id = self.context.authorization else {
            throw Abort(.internalServerError, reason: "Cannot get authorization ID")
        }
        
        let authorization = try payments.get(authorization: id).wait()
        
        XCTAssertEqual(authorization.id, id)
    }
    
    func testCaptureAuthorizationEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        guard let id = self.context.authorization else {
            throw Abort(.internalServerError, reason: "Cannot get authorization ID")
        }
        let capture = try RelatedResource.Capture(
            amount: DetailedAmount(currency: .usd, total: "5.60", details: nil),
            isFinal: true,
            invoice: nil,
            transaction: nil,
            payerNote: nil
        )
        
        let authorization = try payments.capture(authorization: id, with: capture).wait()
        
        XCTAssertEqual(authorization.id, id)
    }
    
    func testReauthAuthorizationEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        guard let id = self.context.authorization else {
            throw Abort(.internalServerError, reason: "Cannot get authorization ID")
        }
        let auth = try RelatedResource.Authorization(
            amount: DetailedAmount(currency: .usd, total: "5.60", details: nil),
            fmf: FraudManagementFilter(type: .pending, id: .unconfirmedAddress, name: "Unconfirmed Shipping Address", description: nil),
            processor: nil
        )
        
        let authorization = try payments.reauthorize(authorization: id, with: auth).wait()
        
        XCTAssertEqual(authorization.id, id)
    }
    
    func testVoidAuthorizationEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        guard let id = self.context.authorization else {
            throw Abort(.internalServerError, reason: "Cannot get authorization ID")
        }
        
        let authorization = try payments.void(authorization: id).wait()
        
        XCTAssertEqual(authorization.id, id)
    }
    
    func testGetOrderEndpoint()throws {
        let payments = try self.app.make(Payments.self)
        guard let id = self.context.order else {
            throw Abort(.internalServerError, reason: "Cannot get order ID")
        }
        
        let order = try payments.get(order: id).wait()
        
        XCTAssertEqual(order.id, id)
    }
    
    static var allTests: [(String, (PaymentsTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testListEndpoint", testListEndpoint),
        ("testPatchEndpoint", testPatchEndpoint),
        ("testGetEndpoint", testGetEndpoint),
        ("testExecuteEndpoint", testExecuteEndpoint),
        ("testGetSaleEndpoint", testGetSaleEndpoint),
        ("testRefundSaleEndpoint", testRefundSaleEndpoint),
        ("testGetAuthorizationEndpoint", testGetAuthorizationEndpoint),
        ("testCaptureAuthorizationEndpoint", testCaptureAuthorizationEndpoint),
        ("testReauthAuthorizationEndpoint", testReauthAuthorizationEndpoint),
        ("testVoidAuthorizationEndpoint", testVoidAuthorizationEndpoint),
        ("testGetOrderEndpoint", testGetOrderEndpoint)
    ]
}

internal struct PaymentTestsContext {
    let address: Address
    let item: Payment.Item
    let details: DetailedAmount.Detail
    let amount: DetailedAmount
    let items: Payment.ItemList
    let transaction: Payment.Transaction
    
    private(set) var sale: String?
    private(set) var authorization: String?
    private(set) var order: String?
    private(set) var payment: String?
    
    init()throws {
        self.address = try Address(
            recipientName: "Ira Harding",
            defaultAddress: true,
            line1: "578 Wild Wood",
            line2: nil,
            city: "New Haven",
            state: "CN",
            countryCode: "US",
            postalCode: "79812",
            phone: nil,
            type: nil
        )
        self.item = try Payment.Item(
            quantity: "3",
            price: "39.00",
            currency: .usd,
            sku: "8EFAFEF3-72D2-4E5C-85EC-C14BA2F9D997",
            name: "Plum Pudding",
            description: "With sugar an inch thick",
            tax: "8.00"
        )
        self.details = try DetailedAmount.Detail(
            subtotal: "117.00",
            shipping: "15.00",
            tax: "8.00",
            handlingFee: "10.00",
            shippingDiscount: nil,
            insurance: nil,
            giftWrap: nil
        )
        self.amount = try DetailedAmount(currency: .usd, total: "150.00", details: details)
        self.items = try Payment.ItemList(
            items: [item],
            address: address,
            phoneNumber: nil
        )
        self.transaction = try Payment.Transaction(
            amount: amount,
            payee: Payee(email: "payee@example.com", merchant: nil, metadata: nil),
            description: nil,
            payeeNote: "Thanks for paying for the order!",
            custom: nil,
            invoice: nil,
            softDescriptor: nil,
            payment: .unrestricted,
            itemList: items,
            notify: "https://example.com/notify"
        )
    }
    
    static func initialize(on container: Container)throws -> PaymentTestsContext {
        var context = try self.init()
        let payments = try container.make(Payments.self)
        let payment = try container.make(Payments.self).list().wait().payments?.first
        
        context.payment = payment?.id
        context.sale = payment?.transactions?.compactMap{$0.resources}.joined(separator:[]).compactMap{$0.sale}.first?.id
        context.authorization = payment?.transactions?.compactMap{$0.resources}.joined(separator:[]).compactMap{$0.authorization}.first?.id
        context.order = payment?.transactions?.compactMap{$0.resources}.joined(separator:[]).compactMap{$0.order}.first?.id
        
        return context
    }
}
