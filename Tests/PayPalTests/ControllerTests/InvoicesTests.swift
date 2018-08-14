import XCTest
import Vapor
import SwiftGD
@testable import PayPal

final class InvoicesTests: XCTestCase {
    
    var app: Application!
    var id: String?
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
        
        let invoices = try! self.app.make(Invoices.self)
        let list = try! invoices.list().wait()
        self.id = list.invoices?.first?.id
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
            custom: CustomAmount(label: nil, amount: Amount(currency: .usd, value: "10.00")),
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
    
    func testUpdateEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
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
            cc: [Invoice.Participant(email: "collective@vapor.codes"), Invoice.Participant(email: "dont.ater@example.com")],
            items: nil,
            date: now,
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
            allowTip: true,
            template: "PayPal system template"
        )
        
        let updated = try invoices.update(invoice: id, with: invoice).wait()
        
        XCTAssertEqual(invoice.date, now)
        XCTAssertEqual(invoice.payment?.due, now)
        XCTAssertEqual(updated.cc?.last?.email, "dont.ater@example.com")
    }
    
    func testDetailsEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let details = try invoices.details(for: id).wait()
        
        XCTAssertEqual(details.id, id)
    }
    
    func testDeleteEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let status = try invoices.deleteDraft(invoice: id).wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testCancelEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let status = try invoices.cancel(invoice: id).wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testDeletePayment()throws {
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let details = try invoices.details(for: id).wait()
        let status = try invoices.deletePayment(transaction: "<figure-out-how-to-get-the-proper-id>", forInvoice: id).wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testGenerateQREndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let code = try invoices.generateQR(for: id).wait()
        guard let data = Data(base64Encoded: code) else {
            throw Abort(.internalServerError, reason: "Unable to decode Base64 encoded string to data")
        }
        
        let qr = try Image(data: data, as: .png)
        
        XCTAssertEqual(qr.size.height, 500)
        XCTAssertEqual(qr.size.width, 500)
    }
    
    func testPaymentEndpoint()throws {
        let now = Date().iso8601
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let payment = try Invoice.Payment(method: .cash, amount: Amount(currency: .usd, value: "10.00"), date: now, note: "I got the payment by cash!")
        let status = try invoices.pay(invoice: id, payment: payment).wait()
        
        XCTAssertEqual(status, .ok)
    }
    
    static var allTests: [(String, (InvoicesTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testListEndpoint", testListEndpoint),
        ("testUpdateEndpoint", testUpdateEndpoint),
        ("testUpdateEndpoint", testUpdateEndpoint),
        ("testDetailsEndpoint", testDetailsEndpoint),
        ("testDeleteEndpoint", testDeleteEndpoint),
        ("testCancelEndpoint", testCancelEndpoint),
        ("testDeletePayment", testDeletePayment),
        ("testGenerateQREndpoint", testGenerateQREndpoint),
        ("testPaymentEndpoint", testPaymentEndpoint)
    ]
}
