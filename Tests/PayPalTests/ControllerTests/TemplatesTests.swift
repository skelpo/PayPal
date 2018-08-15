import XCTest
import Vapor
@testable import PayPal

final class TemplatesTests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
    }
    
    func testServiceExists()throws {
        _ = try app.make(Templates.self)
    }
    
    func testCreateEndpoint()throws {
        let now = Date().iso8601
        let templates = try self.app.make(Templates.self)
        let template = try Template(
            name: "Hours Template",
            default: true,
            data: .init(
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
                cc: [CCEmail(email: "collective@vapor.codes"), CCEmail(email: "donator@example.com")],
                items: nil,
                payment: PaymentTerm(type: .dueOnReceipt, due: now),
                reference: "PO number",
                discount: nil,
                shippingCost: nil,
                custom: CustomAmount(label: nil, amount: Amount(currency: .usd, value: "10.00")),
                allowPartialPayment: false,
                minimumDue: Amount(currency: .usd, value: "1.00"),
                taxCalculatedAfterDiscount: true,
                taxInclusive: true,
                terms: nil,
                note: "Thanks for your donation!",
                memo: "Open Collective donation",
                logo: "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
                attachments: [FileAttachment(name: "photo.png", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")]
            ),
            settings: [
                .init(field: .itemsDate, preference: .init(hidden: true)),
                .init(field: .custom, preference: .init(hidden: true))
            ],
            measureUnit: .hours
        )
        
        let saved = try templates.create(template: template).wait()
        
        XCTAssertNotNil(template.id)
        XCTAssertEqual(saved.name, "Hours Template")
    }
    
    static var allTests: [(String, (TemplatesTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint)
    ]
}


