import XCTest
import Failable
@testable import PayPal

public final class TemplateDataTests: XCTestCase {
    let (now, timlessNow): (Date, String) = {
        let now = Date()
        let timeless = TimelessDate.formatter.string(from: now)
        
        return (now, timeless)
    }()
    
    func testInit()throws {
        let data = try Template.Data(
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
            cc: [.init(email: "collective@vapor.codes"), .init(email: "donator@example.com")],
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
            attachments: [FileAttachment(name: "photo.jpg", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")]
        )
        
        XCTAssertNil(data.total)
        XCTAssertNil(data.shipping)
        XCTAssertNil(data.items)
        XCTAssertNil(data.discount)
        XCTAssertNil(data.shippingCost)
        XCTAssertNil(data.terms)
        
        XCTAssertEqual(data.billing, [])
        XCTAssertEqual(data.payment, PaymentTerm(type: .dueOnReceipt, due: now))
        XCTAssertEqual(data.reference.value, "PO number")
        XCTAssertEqual(data.allowPartialPayment, false)
        XCTAssertEqual(data.taxCalculatedAfterDiscount, true)
        XCTAssertEqual(data.taxInclusive, true)
        XCTAssertEqual(data.note.value, "Thanks for your donation!")
        XCTAssertEqual(data.memo.value, "Open Collective donation")
        XCTAssertEqual(data.logo.value, "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png")
        XCTAssertEqual(data.attachments, [FileAttachment(name: "photo.jpg", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")])
        
        try XCTAssertEqual(data.custom, CustomAmount(label: nil, amount: .init(CurrencyAmount(currency: .usd, value: 10.00))))
        try XCTAssertEqual(data.cc, [.init(email: .init("collective@vapor.codes")), .init(email: .init("donator@example.com"))])
        try XCTAssertEqual(data.merchant, MerchantInfo(
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
        var data = try Template.Data(
            merchant: MerchantInfo(
                email: nil, business: nil, firstName: nil, lastName: nil, address: nil, phone: nil, fax: nil, website: nil, taxID: nil, info: nil
            ),
            reference: .init("PO number"),
            terms: .init("keep going"),
            note: .init("Thanks for your donation!"),
            memo: .init("Open Collective donation"),
            logo: .init("https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png")
        )
        
        try XCTAssertThrowsError(data.reference <~ String(repeating: "n", count: 61))
        try XCTAssertThrowsError(data.terms <~ String(repeating: "n", count: 4_001))
        try XCTAssertThrowsError(data.note <~ String(repeating: "n", count: 4_001))
        try XCTAssertThrowsError(data.memo <~ String(repeating: "n", count: 151))
        try XCTAssertThrowsError(data.logo <~ String(repeating: "n", count: 4_001))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let data = try Template.Data(
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
            cc: [.init(email: "collective@vapor.codes"), .init(email: "donator@example.com")],
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
            attachments: [FileAttachment(name: "photo.jpg", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")]
        )
        let generated = try String(data: encoder.encode(data), encoding: .utf8)!
        let json =
            "{\"tax_calculated_after_discount\":true,\"logo_url\":\"https:\\/\\/vapor.codes\\/dist\\/e032390c38279fbdf18ebf0e763eb44f.png\"," +
            "\"note\":\"Thanks for your donation!\",\"billing_info\":[],\"allow_partial_payment\":false," +
            "\"minimum_amount_due\":{\"currency\":\"USD\",\"value\":\"1\"},\"merchant_info\":{\"email\":\"hello@vapor.codes\"" +
            ",\"last_name\":\"Nelson\",\"website\":\"https:\\/\\/vapor.codes\\/\",\"business_name\":\"Qutheory LLC.\",\"first_name\":\"Tanner\"}," +
            "\"cc_info\":[{\"email\":\"collective@vapor.codes\"},{\"email\":\"donator@example.com\"}],\"payment_term\":{" +
            "\"due_date\":\"\(self.timlessNow)\",\"term_type\":\"DUE_ON_RECEIPT\"}," +
            "\"custom\":{\"amount\":{\"currency\":\"USD\",\"value\":\"10\"}},\"attachments\":[{\"name\":\"photo.jpg\"," +
            "\"url\":\"https:\\/\\/avatars3.githubusercontent.com\\/u\\/2872298?s=200&v=4\"}],\"reference\":\"PO number\",\"tax_inclusive\":true," +
            "\"merchant_memo\":\"Open Collective donation\"}"
        
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
            "invoice_date": "\(self.timlessNow)",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "note": "Thanks for your donation!",
            "billing_info": [],
            "allow_partial_payment": false,
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
                "due_date": "\(self.timlessNow)",
                "term_type": "DUE_ON_RECEIPT"
            },
            "custom": {
                "amount": {
                    "value": "10",
                    "currency": "USD"
                }
            },
            "reference": "PO number",
            "tax_inclusive": true,
            "merchant_memo": "Open Collective donation",
            "attachments": [
                {
                    "name": "photo.jpg",
                    "url": "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4"
                }
            ]
        }
        """.data(using: .utf8)!
        let invalidReference = """
        {
            "reference": "\(String(repeating: "n", count: 61))",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "merchant_memo": "Open Collective donation",
            "note": "Thanks for your donation!",
            "terms": "keep going"
        }
        """.data(using: .utf8)!
        let invalidLogo = """
        {
            "reference": "PO number",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "merchant_memo": "Open Collective donation",
            "note": "Thanks for your donation!",
            "terms": "\(String(repeating: "n", count: 4_001))"
        }
        """.data(using: .utf8)!
        let invalidMemo = """
        {
            "reference": "PO number",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "merchant_memo": "Open Collective donation",
            "note": "\(String(repeating: "n", count: 4_001))",
            "terms": "keep going"
        }
        """.data(using: .utf8)!
        let invalidNote = """
        {
            "reference": "PO number",
            "logo_url": "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
            "merchant_memo": "\(String(repeating: "n", count: 501))",
            "note": "Thanks for your donation!",
            "terms": "keep going"
        }
        """.data(using: .utf8)!
        let invalidTerms = """
        {
            "reference": "PO number",
            "logo_url": "\(String(repeating: "n", count: 4_001))",
            "merchant_memo": "Open Collective donation",
            "note": "Thanks for your donation!",
            "terms": "keep going"
        }
        """.data(using: .utf8)!
        
        let data = try decoder.decode(Template.Data.self, from: json)
        
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidReference))
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidLogo))
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidMemo))
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidNote))
        try XCTAssertThrowsError(decoder.decode(Invoice.self, from: invalidTerms))
        
        try XCTAssertEqual(data, Template.Data(
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
            cc: [.init(email: "collective@vapor.codes"), .init(email: "donator@example.com")],
            items: nil,
            payment: PaymentTerm(type: .dueOnReceipt, due: TimelessDate.formatter.date(from: self.timlessNow)!),
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
            attachments: [FileAttachment(name: "photo.jpg", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")]
        ))
    }
    
    public static var allTests: [(String, (TemplateDataTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



