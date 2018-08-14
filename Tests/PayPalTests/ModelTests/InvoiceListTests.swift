import XCTest
@testable import PayPal

final class InvoiceListTests: XCTestCase {
    let now = Date().iso8601
    
    func testInit()throws {
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
        let list = InvoiceList(invoices: [invoice])
        
        XCTAssertNil(list.links)
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.invoices?.count, 1)
        try XCTAssertEqual(list.invoices?.first, Invoice(
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
        ))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let list = InvoiceList(invoices: [])
        let generated = try String(data: encoder.encode(list), encoding: .utf8)!
        let json = "{\"total_count\":0,\"invoices\":[]}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let list = InvoiceList(invoices: [])
        
        let json = """
        {
            "invoices": [],
            "total_count": 0
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(list, decoder.decode(InvoiceList.self, from: json))
    }
    
    static var allTests: [(String, (InvoiceListTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



