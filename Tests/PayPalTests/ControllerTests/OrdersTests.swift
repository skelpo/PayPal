import XCTest
import Vapor
@testable import PayPal

final class OrdersTests: XCTestCase {
    
    var app: Application!
    var id: String?
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
        
        if self.id == nil {
            try! self.testCreateEndpoints()
        }
    }
    
    func testServiceExists()throws {
        _ = try app.make(Orders.self)
    }
    
    func testCreateEndpoints()throws {
        let sales = [
            Sale(amount: DetailedAmount(currency: .usd, total: 150.78, details:
                DetailedAmount.Detail(
                    subtotal: 140.00,
                    shipping: 9.00,
                    tax: 1.78,
                    handlingFee: nil,
                    shippingDiscount: nil,
                    insurance: nil,
                    giftWrap: nil)
                ),
                transaction: CurrencyAmount(currency: .usd, value: 1.50)
            )
        ]
        
        let order = try Order(
            intent: .sale,
            units: [
                Order.Unit(
                    reference: "FB68DC33-FA23-44D4-B197-C9251D76286E",
                    amount: DetailedAmount(currency: .usd, total: 140.00, details: nil),
                    payee: Payee(email: "payee@example.com", merchant: nil, metadata: nil),
                    description: "Unit",
                    invoice: "FB68DC33-FA23-44D4-B197-C9251D76286E",
                    custom: nil,
                    paymentDescriptor: nil,
                    items: [
                        Order.Item(
                            sku: "6CC0A22C-3260-48B7-B7A0-CCF372841391",
                            name: "Widget",
                            description: "It's blue",
                            quantity: "4",
                            price: "35.00",
                            currency: .usd,
                            tax: nil
                        )
                    ],
                    notify: "https://example.com/success",
                    shippingAddress: Address(
                        recipientName: "Felix Minstral",
                        defaultAddress: true,
                        line1: "648 New Borne St.",
                        line2: nil,
                        city: "Armagedon",
                        state: .il,
                        country: .unitedStates,
                        postalCode: "456813",
                        phone: nil,
                        type: nil
                    ),
                    shippingMethod: "USPSParcel",
                    partnerFee: nil,
                    paymentGroup: nil,
                    metadata: nil,
                    payment: nil
                )
            ],
            payment: .init(captures: nil, refunds: nil, sales: sales, authorizations: nil),
            total: nil,
            context: AppContext(brand: "Example Inc.", locale: "us-AZ", landingPage: nil, shipping: .buyer, userAction: nil, data: nil),
            metadata: nil,
            redirects: .init(return: "https://example.com/approved", cancel: "https://example.com/cancel")
        )
        
        let orders = try self.app.make(Orders.self)
        let created = try orders.create(order: order, partnerID: nil).wait()
        
        XCTAssertNotNil(created.id)
        XCTAssertEqual(created.context?.brand, "Example Inc.")
        
        self.id = created.id
    }
    
    func testCancelEndpoints()throws {
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for test")
        }
        let orders = try self.app.make(Orders.self)
        let status = try orders.cancel(order: id).wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testDetailsEndpoint()throws {
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for test")
        }
        let orders = try self.app.make(Orders.self)
        let order = try orders.details(for: id).wait()
        
        XCTAssertEqual(order.id, id)
    }
    
    func testPayEndpoint()throws {
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for test")
        }
        let body = try Order.PaymentRequest(
            disbursement: .instant,
            payer: Order.Payer(
                method: .creditCard,
                funding: [
                    FundingInstrument(token: CreditCard.Token(creditCard: "C324C867-B0D8-4522-881E-6D788A159DB4", payer: "C324C867-B0D8-4522-881E-6D788A159DB4"))
                ],
                info: Order.Payer.Info(email: "email@example.com", birthdate: nil, tax: nil, taxType: nil, country: .unitedStates, billing: nil)
            )
        )
        
        let orders = try self.app.make(Orders.self)
        let order = try orders.pay(order: id, with: body).wait()
        
        XCTAssertEqual(order.id, id)
    }
    
    static var allTests: [(String, (OrdersTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoints", testCreateEndpoints),
        ("testCancelEndpoints", testCancelEndpoints),
        ("testDetailsEndpoint", testDetailsEndpoint),
        ("testPayEndpoint", testPayEndpoint)
    ]
}

