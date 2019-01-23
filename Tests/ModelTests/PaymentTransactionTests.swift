import XCTest
import Failable
@testable import PayPal

final class PaymentTransactionTests: XCTestCase {
    func testInit()throws {
        let transaction = try Payment.Transaction(
            amount: DetailedAmount(currency: .usd, total: 54.56, details: nil),
            payee: .init(email: nil, merchant: nil, metadata: nil),
            description: .init("Description"),
            payeeNote: .init("noted"),
            custom: .init("custom"),
            invoice: .init("12-654-89"),
            softDescriptor: .init("22"),
            payment: .unrestricted,
            itemList: .init(items: nil, address: nil, phoneNumber: nil),
            notify: .init("https://example.com/notify")
        )

        XCTAssertNil(transaction.resources)
        XCTAssertEqual(transaction.payee, .init(email: nil, merchant: nil, metadata: nil))
        XCTAssertEqual(transaction.description.value, "Description")
        XCTAssertEqual(transaction.payeeNote.value, "noted")
        XCTAssertEqual(transaction.custom.value, "custom")
        XCTAssertEqual(transaction.invoice.value, "12-654-89")
        XCTAssertEqual(transaction.softDescriptor.value, "22")
        XCTAssertEqual(transaction.payment, Payment.Options(allowed: .unrestricted))
        XCTAssertEqual(transaction.notify.value, "https://example.com/notify")
        XCTAssertEqual(transaction.itemList, .init(items: nil, address: nil, phoneNumber: nil))
    }
    
    func testValidations()throws {
        var transaction = try Payment.Transaction(
            amount: DetailedAmount(currency: .usd, total: 54.56, details: nil),
            payee: .init(email: nil, merchant: nil, metadata: nil),
            description: .init("Description"),
            payeeNote: .init("noted"),
            custom: .init("custom"),
            invoice: .init("12-654-89"),
            softDescriptor: .init("22"),
            payment: .unrestricted,
            itemList: .init(items: nil, address: nil, phoneNumber: nil),
            notify: .init("https://example.com/notify")
        )
        
        
        try XCTAssertThrowsError(transaction.description <~ String(repeating: "d", count: 128))
        try XCTAssertThrowsError(transaction.payeeNote <~ String(repeating: "dp", count: 256))
        try XCTAssertThrowsError(transaction.custom <~ String(repeating: "c", count: 128))
        try XCTAssertThrowsError(transaction.invoice <~ String(repeating: "i", count: 128))
        try XCTAssertThrowsError(transaction.softDescriptor <~ String(repeating: "s", count: 23))
        try XCTAssertThrowsError(transaction.notify <~ String(repeating: "d", count: 2049))
        try transaction.description <~ String(repeating: "d", count: 127)
        try transaction.payeeNote <~ String(repeating: "p", count: 255)
        try transaction.custom <~ String(repeating: "c", count: 127)
        try transaction.invoice <~ String(repeating: "i", count: 127)
        try transaction.softDescriptor <~ String(repeating: "s", count: 22)
        try transaction.notify <~ String(repeating: "d", count: 2048)
        
        XCTAssertEqual(transaction.description.value, String(repeating: "d", count: 127))
        XCTAssertEqual(transaction.payeeNote.value, String(repeating: "p", count: 255))
        XCTAssertEqual(transaction.custom.value, String(repeating: "c", count: 127))
        XCTAssertEqual(transaction.invoice.value, String(repeating: "i", count: 127))
        XCTAssertEqual(transaction.softDescriptor.value, String(repeating: "s", count: 22))
        XCTAssertEqual(transaction.notify.value, String(repeating: "d", count: 2048))
        
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let transaction = try Payment.Transaction(
            amount: DetailedAmount(currency: .usd, total: 54.56, details: nil),
            payee: .init(email: nil, merchant: nil, metadata: nil),
            description: .init("Description"),
            payeeNote: .init("noted"),
            custom: .init("custom"),
            invoice: .init("12-654-89"),
            softDescriptor: .init("22"),
            payment: .unrestricted,
            itemList: .init(items: nil, address: nil, phoneNumber: nil),
            notify: .init("https://example.com/notify")
        )
        let generated = try String(data: encoder.encode(transaction), encoding: .utf8)!
        let json =
            "{\"amount\":{\"currency\":\"USD\",\"total\":\"54.56\"},\"custom\":\"custom\",\"item_list\":{}," +
            "\"notify_url\":\"https:\\/\\/example.com\\/notify\",\"payment_options\":{\"allowed_payment_method\":\"UNRESTRICTED\"}," +
            "\"soft_descriptor\":\"22\",\"description\":\"Description\",\"invoice_number\":\"12-654-89\",\"payee\":{},\"note_to_payee\":\"noted\"}"
        
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
            "amount": {
                "currency": "USD",
                "total": "54.56"
            },
            "item_list": {},
            "payment_options": {
                "allowed_payment_method": "UNRESTRICTED"
            },
            "soft_descriptor": "22",
            "invoice_number": "12-654-89",
            "custom": "custom",
            "note_to_payee": "noted",
            "description": "Description",
            "payee": {},
            "notify_url": "https://example.com/notify",
            "related_resources": []
        }
        """.data(using: .utf8)!
        
        let transaction = try decoder.decode(Payment.Transaction.self, from: json)
        
        XCTAssertEqual(transaction.payee, .init(email: nil, merchant: nil, metadata: nil))
        XCTAssertEqual(transaction.description.value, "Description")
        XCTAssertEqual(transaction.payeeNote.value, "noted")
        XCTAssertEqual(transaction.custom.value, "custom")
        XCTAssertEqual(transaction.invoice.value, "12-654-89")
        XCTAssertEqual(transaction.softDescriptor.value, "22")
        XCTAssertEqual(transaction.payment, Payment.Options(allowed: .unrestricted))
        XCTAssertEqual(transaction.notify.value, "https://example.com/notify")
        XCTAssertEqual(transaction.resources, [])
        XCTAssertEqual(transaction.itemList, .init(items: nil, address: nil, phoneNumber: nil))
    }
    
    static var allTests: [(String, (PaymentTransactionTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





