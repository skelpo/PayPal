import XCTest
import Vapor
@testable import PayPal

public final class TemplatesTests: XCTestCase {
    
    var app: Application!
    var id: String?
    
    override public func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
        
        let templates = try! self.app.make(Templates.self)
        let list = try! templates.list().wait()
        self.id = list.templates?.first?.id
    }
    
    func testServiceExists()throws {
        _ = try app.make(Templates.self)
    }
    
    func testCreateEndpoint()throws {
        let now = Date()
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
                cc: [.init(email: .init("collective@vapor.codes")), .init(email: .init("donator@example.com"))],
                items: nil,
                payment: PaymentTerm(type: .dueOnReceipt, due: now),
                reference: .init("PO number"),
                discount: nil,
                shippingCost: nil,
                custom: CustomAmount(label: nil, amount: .init(CurrencyAmount(currency: .usd, value: 10.00))),
                allowPartialPayment: false,
                minimumDue: CurrencyAmount(currency: .usd, value: 1.00),
                taxCalculatedAfterDiscount: true,
                taxInclusive: true,
                terms: nil,
                note: .init("Thanks for your donation!"),
                memo: .init("Open Collective donation"),
                logo: .init("https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png"),
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
    
    func testListEndpoint()throws {
        let templates = try self.app.make(Templates.self)
        
        let list = try templates.list().wait()
        
        XCTAssert(list.templates?.count ?? 0 > 0 && list.templates?.count ?? 0 <= 50)
    }
    
    func testUpdateEndpoint()throws {
        let templates = try self.app.make(Templates.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Could not get ID of template to update")
        }
        
        let now = Date()
        let template = try Template(
            name: "Donation Template",
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
                cc: [.init(email: .init("collective@vapor.codes")), .init(email: .init("donator@example.com"))],
                items: nil,
                payment: PaymentTerm(type: .dueOnReceipt, due: now),
                reference: .init("PO number"),
                discount: nil,
                shippingCost: nil,
                custom: CustomAmount(label: nil, amount: .init(CurrencyAmount(currency: .usd, value: 10.00))),
                allowPartialPayment: false,
                minimumDue: CurrencyAmount(currency: .usd, value: 1.00),
                taxCalculatedAfterDiscount: true,
                taxInclusive: true,
                terms: nil,
                note: .init("Thanks for your donation!"),
                memo: .init("Open Collective donation"),
                logo: .init("https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png"),
                attachments: [FileAttachment(name: "photo.png", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")]
            ),
            settings: [
                .init(field: .itemsDate, preference: .init(hidden: true)),
                .init(field: .custom, preference: .init(hidden: true))
            ],
            measureUnit: .hours
        )
        
        let updated = try templates.update(template: id, with: template).wait()
        
        XCTAssertEqual(updated.id, id)
        XCTAssertEqual(updated.name, "Donation Template")
    }
    
    func testDeleteEndpoint()throws {
        let templates = try self.app.make(Templates.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Could not get ID of template to update")
        }
        
        let status = try templates.delete(template: id).wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testDetailsEndpoint()throws {
        let templates = try self.app.make(Templates.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Could not get ID of template to update")
        }
        
        let details = try templates.details(for: id).wait()
        
        XCTAssertEqual(details.id, id)
    }
    
    public static var allTests: [(String, (TemplatesTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testListEndpoint", testListEndpoint),
        ("testUpdateEndpoint", testUpdateEndpoint),
        ("testDeleteEndpoint", testDeleteEndpoint),
        ("testDetailsEndpoint", testDetailsEndpoint)
    ]
}


