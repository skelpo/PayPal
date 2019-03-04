import XCTest
import Vapor
import SwiftGD
@testable import PayPal

public final class InvoicesTests: XCTestCase {
    
    var app: Application!
    var id: String?
    
    override public func setUp() {
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
        
        let now = Date()
        let invoice = try Invoice(
            number: nil,
            merchant: MerchantInfo(
                email: .init("dispute@skelpo.com"),
                business: .init("Qutheory LLC."),
                firstName: .init("Tanner"),
                lastName: .init("Nelson"),
                address: nil,
                phone: nil,
                fax: nil,
                website: .init("https://vapor.codes/"),
                taxID: nil,
                info: nil
            ),
            billing: [
                BillingInfo(
                    email: .init("payer@example.com"),
                    phone: nil,
                    firstName: .init("Lester"),
                    lastName: .init("Dickerson"),
                    businessName: nil,
                    address: Address(
                        recipientName: "Lester Dickerson",
                        defaultAddress: true,
                        line1: "314 New Berry ln.",
                        line2: nil,
                        city: "Chancer",
                        state: .ky,
                        country: .unitedStates,
                        postalCode: "489156",
                        phone: nil,
                        type: nil
                    ),
                    language: .en_US,
                    info: nil
                )
            ],
            shipping: nil,
            cc: [Invoice.Participant(email: "collective@vapor.codes"), Invoice.Participant(email: "donator@example.com")],
            items: nil,
            date: now,
            payment: PaymentTerm(type: .dueOnReceipt, due: now),
            reference: .init("PO number"),
            discount: nil,
            shippingCost: nil,
            custom: CustomAmount(label: .init("Dough"), amount: .init(CurrencyAmount(currency: .usd, value: 10.00))),
            allowPartialPayment: false,
            minimumDue: CurrencyAmount(currency: .usd, value: 1.00),
            taxCalculatedAfterDiscount: true,
            taxInclusive: true,
            terms: nil,
            note: .init("Thanks for your donation!"),
            memo: .init("Open Collective donation"),
            logo: .init("https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png"),
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
        let now = Date()
        let invoice = try Invoice(
            number: nil,
            merchant: MerchantInfo(
                email: .init("hello@vapor.codes"),
                business: .init("Qutheory LLC."),
                firstName: .init("Tanner"),
                lastName: .init("Nelson"),
                address: nil,
                phone: nil,
                fax: nil,
                website: .init("https://vapor.codes/"),
                taxID: nil,
                info: nil
            ),
            billing: [],
            shipping: nil,
            cc: [Invoice.Participant(email: "collective@vapor.codes"), Invoice.Participant(email: "dont.ater@example.com")],
            items: nil,
            date: now,
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
            allowTip: true,
            template: "PayPal system template"
        )
        
        let updated = try invoices.update(invoice: id, with: invoice).wait()
        
        XCTAssertEqual(invoice.date?.date, now)
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
        let status = try invoices.delete(payment: "<figure-out-how-to-get-the-proper-id>", forInvoice: id).wait()
        
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
        let now = Date()
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let payment = Invoice.Payment(method: .cash, amount: CurrencyAmount(currency: .usd, value: 10.00), date: now, note: "I got the payment by cash!")
        let status = try invoices.pay(invoice: id, payment: payment).wait()
        
        XCTAssertEqual(status, .ok)
    }
    
    func testRefundEndpoint()throws {
        let now = Date()
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let payment = Invoice.Payment(amount: CurrencyAmount(currency: .usd, value: 10.00), date: now, note: "I refunded the payment of cash")
        let status = try invoices.refund(invoice: id, payment: payment).wait()
        
        XCTAssertEqual(status, .ok)
    }
    
    func testReminderEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let reminder = try Invoice.Reminder(subject: "Invoice Not Sent", note: "Please send the money", emails: [.init(email: .init("payer@example.com"))])
        let status = try invoices.remind(invoice: id, with: reminder).wait()
        
        XCTAssertEqual(status, .accepted)
    }
    
    func testScheduleEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let links = try invoices.schedule(invoice: id).wait()
        
        XCTAssertEqual(links.first?.href, "https://api.sandbox.paypal.com/v1/invoicing/invoices/\(id)")
    }
    
    func testSendEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let status = try invoices.send(invoice: id).wait()
        
        XCTAssertEqual(status, .accepted)
    }
    
    func testNumberEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get ID for updating invoice")
        }
        
        let number = try invoices.nextNumber().wait()
        
        XCTAssertNotEqual(number, id)
    }
    
    func testSearchEndpoint()throws {
        let invoices = try self.app.make(Invoices.self)
        let criteria = Invoice.Search(lowerAmount: "9.00", page: 0, pageSize: 1)
        let emptyCriteria = Invoice.Search(upperAmount: "9.00", page: 0, pageSize: 1)
        
        let list = try invoices.search(with: criteria).wait()
        let empty = try invoices.search(with: emptyCriteria).wait()
        
        XCTAssertEqual(list.invoices?.count, 1)
        XCTAssertGreaterThanOrEqual(list.invoices?.first?.total?.value ?? 0.00, 9.00)
        
        XCTAssertEqual(empty.invoices?.count, 0)
    }
    
    public static var allTests: [(String, (InvoicesTests) -> ()throws -> ())] = [
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
        ("testPaymentEndpoint", testPaymentEndpoint),
        ("testRefundEndpoint", testRefundEndpoint),
        ("testRefundEndpoint", testRefundEndpoint),
        ("testReminderEndpoint", testReminderEndpoint),
        ("testScheduleEndpoint", testScheduleEndpoint),
        ("testSendEndpoint", testSendEndpoint),
        ("testNumberEndpoint", testNumberEndpoint),
        ("testSearchEndpoint", testSearchEndpoint)
    ]
}

extension DateFormatter {
    static let isoTZ: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd z"
        return formatter
    }()
}

extension Date {
    var isoTZ: String {
        return DateFormatter.isoTZ.string(from: self)
    }
}
