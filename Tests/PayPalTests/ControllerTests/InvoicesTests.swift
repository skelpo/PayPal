import XCTest
import Vapor
@testable import PayPal

final class InvoicesTests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
    }
    
    func testServiceExists()throws {
        _ = try app.make(Invoices.self)
    }
    
    func testCreateEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        
        let now = Date().iso8601
        let invoice = try Invoice(
            number: nil,
            merchant: MerchantInfo(
                email: "hello@vapor.codes",
                business: "Qutheory LLC.",
                firstName: "Tanner",
                lastName: "Nelson",
                address: nil,
                phone: nil,
                fax: nil,
                website: "https://vapor.codes/",
                taxID: nil,
                info: nil
            ),
            billing: [],
            shipping: nil,
            cc: [Invoice.Participant(email: "collective@vapor.codes"), Invoice.Participant(email: "donator@example.com")],
            items: nil,
            date: now,
            payment: PaymentTerm(type: .dueOnReceipt, due: now),
            reference: "PO number",
            discount: nil,
            shippingCost: nil,
            custom: CustomAmount(label: nil, amount: Amount(currency: .usd, value: "")),
            allowPartialPayment: false,
            minimumDue: Amount(currency: .usd, value: "1.00"),
            taxCalculatedAfterDiscount: true,
            taxInclusive: true,
            terms: nil,
            note: "Thanks for your donation!",
            memo: "Open Collective donation",
            logo: "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            allowTip: true,
            template: "PayPal system template"
        )
        
        let saved = try invoices.create(invoice: invoice).wait()
        
        XCTAssertNotNil(saved.id)
    }
    
    func testListEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        let list = try invoices.list().wait()
        
        XCTAssertGreaterThan(list.count ?? 0, 0)
    }
    
    static var allTests: [(String, (InvoicesTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testListEndpoint", testListEndpoint)
    ]
}
