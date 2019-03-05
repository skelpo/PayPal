import XCTest
@testable import PayPal

public final class InvoiceTests: XCTestCase {
    let now = Date()
    
    var dueStr: String {
        return TimelessDate.formatter.string(from: self.now)
    }
    var due: Date {
        return TimelessDate.formatter.date(from: TimelessDate.formatter.string(from: self.now))!
    }
    
    func testInit()throws {
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
            cc: [Invoice.Participant(email: "collective@vapor.codes"), Invoice.Participant(email: "donator@example.com")],
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
        
        XCTAssertNil(invoice.id)
        XCTAssertNil(invoice.status)
        XCTAssertNil(invoice.total)
        XCTAssertNil(invoice.refunds)
        XCTAssertNil(invoice.metadata)
        XCTAssertNil(invoice.refunded)
        XCTAssertNil(invoice.attachments)
        XCTAssertNil(invoice.links)
        XCTAssertNil(invoice.number)
        XCTAssertNil(invoice.shipping)
        XCTAssertNil(invoice.items)
        XCTAssertNil(invoice.discount)
        XCTAssertNil(invoice.shippingCost)
        XCTAssertNil(invoice.terms)
        
        XCTAssertEqual(invoice.billing, [])
        XCTAssertEqual(invoice.date, now)
        XCTAssertEqual(invoice.payment, PaymentTerm(type: .dueOnReceipt, due: now))
        XCTAssertEqual(invoice.reference.value, "PO number")
        XCTAssertEqual(invoice.allowPartialPayment, false)
        XCTAssertEqual(invoice.taxCalculatedAfterDiscount, true)
        XCTAssertEqual(invoice.taxInclusive, true)
        XCTAssertEqual(invoice.note.value, "Thanks for your donation!")
        XCTAssertEqual(invoice.memo.value, "Open Collective donation")
        XCTAssertEqual(invoice.logo.value, "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png")
        XCTAssertEqual(invoice.allowTip, true)
        XCTAssertEqual(invoice.template, "PayPal system template")
        XCTAssertEqual(invoice.cc, [Invoice.Participant(email: "collective@vapor.codes"), Invoice.Participant(email: "donator@example.com")])
        
        try XCTAssertEqual(invoice.custom, CustomAmount(label: nil, amount: .init(CurrencyAmount(currency: .usd, value: 10.00))))
        try XCTAssertEqual(invoice.merchant, MerchantInfo(
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
        ))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Invoice(
            number: 6751,
            merchant: MerchantInfo(
                email: nil, business: nil, firstName: nil, lastName: nil, address: nil, phone: nil, fax: nil, website: nil, taxID: nil, info: nil
            ),
            reference: .init(String(repeating: "n", count: 61)),
            terms: .init("keep going"),
            note: .init("Thanks for your donation!"),
            memo: .init("Open Collective donation"),
            logo: .init("https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png")
        ))
        try XCTAssertThrowsError(Invoice(
            number: 6751,
            merchant: MerchantInfo(
                email: nil, business: nil, firstName: nil, lastName: nil, address: nil, phone: nil, fax: nil, website: nil, taxID: nil, info: nil
            ),
            reference: .init("PO number"),
            terms: .init(String(repeating: "n", count: 4_001)),
            note: .init("Thanks for your donation!"),
            memo: .init("Open Collective donation"),
            logo: .init("https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png")
        ))
        try XCTAssertThrowsError(Invoice(
            number: 6751,
            merchant: MerchantInfo(
                email: nil, business: nil, firstName: nil, lastName: nil, address: nil, phone: nil, fax: nil, website: nil, taxID: nil, info: nil
            ),
            reference: .init("PO number"),
            terms: .init("keep going"),
            note: .init(String(repeating: "n", count: 4_001)),
            memo: .init("Open Collective donation"),
            logo: .init("https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png")
        ))
        try XCTAssertThrowsError(Invoice(
            number: 6751,
            merchant: MerchantInfo(
                email: nil, business: nil, firstName: nil, lastName: nil, address: nil, phone: nil, fax: nil, website: nil, taxID: nil, info: nil
            ),
            reference: .init("PO number"),
            terms: .init("keep going"),
            note: .init("Thanks for your donation!"),
            memo: .init(String(repeating: "n", count: 501)),
            logo: .init("https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png")
        ))
        try XCTAssertThrowsError(Invoice(
            number: 6751,
            merchant: MerchantInfo(
                email: nil, business: nil, firstName: nil, lastName: nil, address: nil, phone: nil, fax: nil, website: nil, taxID: nil, info: nil
            ),
            reference: .init("PO number"),
            terms: .init("keep going"),
            note: .init("Thanks for your donation!"),
            memo: .init("Open Collective donation"),
            logo: .init(String(repeating: "n", count: 4_001))
        ))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
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
            cc: [Invoice.Participant(email: "collective@vapor.codes"), Invoice.Participant(email: "donator@example.com")],
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
        let generated = try String(data: encoder.encode(invoice), encoding: .utf8)!
        let json =
            "{\"tax_calculated_after_discount\":true,\"invoice_date\":\"\(now.iso8601)\"," +
            "\"logo_url\":\"https:\\/\\/vapor.codes\\/dist\\/e032390c38279fbdf18ebf0e763eb44f.png\"," +
            "\"note\":\"Thanks for your donation!\",\"billing_info\":[],\"allow_partial_payment\":false,\"template_id\":\"PayPal system template\"," +
            "\"minimum_amount_due\":{\"currency\":\"USD\",\"value\":\"1\"},\"merchant_info\":{\"email\":\"hello@vapor.codes\"" +
            ",\"last_name\":\"Nelson\",\"website\":\"https:\\/\\/vapor.codes\\/\",\"business_name\":\"Qutheory LLC.\",\"first_name\":\"Tanner\"}," +
            "\"cc_info\":[{\"email\":\"collective@vapor.codes\"},{\"email\":\"donator@example.com\"}],\"payment_term\":{" +
            "\"due_date\":\"\(self.dueStr)\",\"term_type\":\"DUE_ON_RECEIPT\"},\"custom\":{\"amount\":{\"currency\":\"USD\",\"value\":\"10\"}}," +
            "\"allow_tip\":true,\"reference\":\"PO number\",\"tax_inclusive\":true,\"merchant_memo\":\"Open Collective donation\"}"
        print(json.count)
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }

        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "tax_calculated_after_discount": true,
            "invoice_date": "\(now.iso8601)",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "note": "Thanks for your donation!",
            "billing_info": [],
            "allow_partial_payment": false,
            "template_id": "PayPal system template",
            "minimum_amount_due": {
                "value": "1",
                "currency": "USD"
            },
            "merchant_info": {
                "email": "hello@vapor.codes",
                "business_name": "Qutheory LLC.",
                "first_name": "Tanner",
                "last_name": "Nelson",
                "website": "https://vapor.codes/"
            },
            "cc_info": [
                {
                    "email": "collective@vapor.codes"
                },
                {
                    "email": "donator@example.com"
                }
            ],
            "payment_term": {
                "due_date": "\(self.dueStr)",
                "term_type": "DUE_ON_RECEIPT"
            },
            "custom": {
                "amount": {
                    "value": "10",
                    "currency": "USD"
                }
            },
            "allow_tip": true,
            "reference": "PO number",
            "tax_inclusive": true,
            "merchant_memo": "Open Collective donation"
        }
        """.data(using: .utf8)!
        let invalidNumber = """
        {
            "number": "\(String(repeating: "7", count: 26))",
            "reference": "PO number",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "merchant_memo": "Open Collective donation",
            "note": "Thanks for your donation!",
            "terms": "keep going"
        }
        """.data(using: .utf8)!
        let invalidReference = """
        {
            "number": "159357",
            "reference": "\(String(repeating: "n", count: 61))",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "merchant_memo": "Open Collective donation",
            "note": "Thanks for your donation!",
            "terms": "keep going"
        }
        """.data(using: .utf8)!
        let invalidLogo = """
        {
            "number": "159357",
            "reference": "PO number",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "merchant_memo": "Open Collective donation",
            "note": "Thanks for your donation!",
            "terms": "\(String(repeating: "n", count: 4_001))"
        }
        """.data(using: .utf8)!
        let invalidMemo = """
        {
            "number": "159357",
            "reference": "PO number",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "merchant_memo": "Open Collective donation",
            "note": "\(String(repeating: "n", count: 4_001))",
            "terms": "keep going"
        }
        """.data(using: .utf8)!
        let invalidNote = """
        {
            "number": "159357",
            "reference": "PO number",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "merchant_memo": "\(String(repeating: "n", count: 501))",
            "note": "Thanks for your donation!",
            "terms": "keep going"
        }
        """.data(using: .utf8)!
        let invalidTerms = """
        {
            "number": "159357",
            "reference": "PO number",
            "logo_url": "\(String(repeating: "n", count: 4_001))",
            "merchant_memo": "Open Collective donation",
            "note": "Thanks for your donation!",
            "terms": "keep going"
        }
        """.data(using: .utf8)!
        
        let invoice = try decoder.decode(Invoice.self, from: json)
        
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidNumber))
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidReference))
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidLogo))
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidMemo))
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidNote))
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidTerms))

        try XCTAssertEqual(invoice, Invoice(
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
            cc: [Invoice.Participant(email: "collective@vapor.codes"), Invoice.Participant(email: "donator@example.com")],
            items: nil,
            date: now,
            payment: PaymentTerm(type: .dueOnReceipt, due: self.due),
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
        ))
    }
    
    public static var allTests: [(String, (InvoiceTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


