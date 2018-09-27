import XCTest
@testable import PayPal

final class PaymentTransactionTests: XCTestCase {
    func testInit()throws {
        let transaction = try Payment.Transaction(
            amount: DetailedAmount(currency: .usd, total: "54.56", details: nil),
            payee: .init(email: nil, merchant: nil, metadata: nil),
            description: "Description",
            payeeNote: "noted",
            custom: "custom",
            invoice: "12-654-89",
            softDescriptor: "22",
            payment: .unrestricted,
            itemList: .init(items: nil, address: nil, phoneNumber: nil),
            notify: "https://example.com/notify"
        )

        XCTAssertNil(transaction.resources)
        XCTAssertEqual(transaction.payee, .init(email: nil, merchant: nil, metadata: nil))
        XCTAssertEqual(transaction.description, "Description")
        XCTAssertEqual(transaction.payeeNote, "noted")
        XCTAssertEqual(transaction.custom, "custom")
        XCTAssertEqual(transaction.invoice, "12-654-89")
        XCTAssertEqual(transaction.softDescriptor, "22")
        XCTAssertEqual(transaction.payment, .unrestricted)
        XCTAssertEqual(transaction.notify, "https://example.com/notify")
        try XCTAssertEqual(transaction.itemList, .init(items: nil, address: nil, phoneNumber: nil))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Payment.Transaction(
            amount: nil, payee: nil, description: String(repeating: "d", count: 128), payeeNote: nil, custom: nil, invoice: nil,
            softDescriptor: nil, payment: nil, itemList: nil, notify: nil
        ))
        try XCTAssertThrowsError(Payment.Transaction(
            amount: nil, payee: nil, description: nil, payeeNote: String(repeating: "p", count: 256), custom: nil, invoice: nil,
            softDescriptor: nil, payment: nil, itemList: nil, notify: nil
        ))
        try XCTAssertThrowsError(Payment.Transaction(
            amount: nil, payee: nil, description: nil, payeeNote: nil, custom: String(repeating: "c", count: 128), invoice: nil,
            softDescriptor: nil, payment: nil, itemList: nil, notify: nil
        ))
        try XCTAssertThrowsError(Payment.Transaction(
            amount: nil, payee: nil, description: nil, payeeNote: nil, custom: nil, invoice: String(repeating: "i", count: 128),
            softDescriptor: nil, payment: nil, itemList: nil, notify: nil
        ))
        try XCTAssertThrowsError(Payment.Transaction(
            amount: nil, payee: nil, description: nil, payeeNote: nil, custom: nil, invoice: nil,
            softDescriptor: String(repeating: "s", count: 23), payment: nil, itemList: nil, notify: nil
        ))
        try XCTAssertThrowsError(Payment.Transaction(
            amount: nil, payee: nil, description: nil, payeeNote: nil, custom: nil, invoice: nil,
            softDescriptor: nil, payment: nil, itemList: nil, notify: String(repeating: "n", count: 2049)
        ))
        var transaction = try Payment.Transaction(
            amount: DetailedAmount(currency: .usd, total: "54.56", details: nil),
            payee: .init(email: nil, merchant: nil, metadata: nil),
            description: "Description",
            payeeNote: "noted",
            custom: "custom",
            invoice: "12-654-89",
            softDescriptor: "22",
            payment: .unrestricted,
            itemList: .init(items: nil, address: nil, phoneNumber: nil),
            notify: "https://example.com/notify"
        )
        
        
        try XCTAssertThrowsError(transaction.set(\Payment.Transaction.description, to: String(repeating: "d", count: 128)))
        try XCTAssertThrowsError(transaction.set(\Payment.Transaction.payeeNote, to: String(repeating: "dp", count: 256)))
        try XCTAssertThrowsError(transaction.set(\Payment.Transaction.custom, to: String(repeating: "c", count: 128)))
        try XCTAssertThrowsError(transaction.set(\Payment.Transaction.invoice, to: String(repeating: "i", count: 128)))
        try XCTAssertThrowsError(transaction.set(\Payment.Transaction.softDescriptor, to: String(repeating: "s", count: 23)))
        try XCTAssertThrowsError(transaction.set(\Payment.Transaction.notify, to: String(repeating: "d", count: 2049)))
        try transaction.set(\Payment.Transaction.description, to: String(repeating: "d", count: 127))
        try transaction.set(\Payment.Transaction.payeeNote, to: String(repeating: "p", count: 255))
        try transaction.set(\Payment.Transaction.custom, to: String(repeating: "c", count: 127))
        try transaction.set(\Payment.Transaction.invoice, to: String(repeating: "i", count: 127))
        try transaction.set(\Payment.Transaction.softDescriptor, to: String(repeating: "s", count: 22))
        try transaction.set(\Payment.Transaction.notify, to: String(repeating: "d", count: 2048))
        
        XCTAssertEqual(transaction.description, String(repeating: "d", count: 127))
        XCTAssertEqual(transaction.payeeNote, String(repeating: "p", count: 255))
        XCTAssertEqual(transaction.custom, String(repeating: "c", count: 127))
        XCTAssertEqual(transaction.invoice, String(repeating: "i", count: 127))
        XCTAssertEqual(transaction.softDescriptor, String(repeating: "s", count: 22))
        XCTAssertEqual(transaction.notify, String(repeating: "d", count: 2048))
        
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let transaction = try Payment.Transaction(
            amount: DetailedAmount(currency: .usd, total: "54.56", details: nil),
            payee: .init(email: nil, merchant: nil, metadata: nil),
            description: "Description",
            payeeNote: "noted",
            custom: "custom",
            invoice: "12-654-89",
            softDescriptor: "22",
            payment: .unrestricted,
            itemList: .init(items: nil, address: nil, phoneNumber: nil),
            notify: "https://example.com/notify"
        )
        let generated = try String(data: encoder.encode(transaction), encoding: .utf8)!
        let json =
            "{\"amount\":{\"currency\":\"USD\",\"total\":\"54.56\"},\"custom\":\"custom\",\"item_list\":{}," +
            "\"notify_url\":\"https:\\/\\/example.com\\/notify\",\"payment_options\":\"UNRESTRICTED\",\"soft_descriptor\":\"22\"," +
            "\"description\":\"Description\",\"invoice_number\":\"12-654-89\",\"payee\":{},\"note_to_payee\":\"noted\"}"
        
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
            "payment_options": "UNRESTRICTED",
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
        XCTAssertEqual(transaction.description, "Description")
        XCTAssertEqual(transaction.payeeNote, "noted")
        XCTAssertEqual(transaction.custom, "custom")
        XCTAssertEqual(transaction.invoice, "12-654-89")
        XCTAssertEqual(transaction.softDescriptor, "22")
        XCTAssertEqual(transaction.payment, .unrestricted)
        XCTAssertEqual(transaction.notify, "https://example.com/notify")
        XCTAssertEqual(transaction.resources, [])
        try XCTAssertEqual(transaction.itemList, .init(items: nil, address: nil, phoneNumber: nil))
    }
    
    static var allTests: [(String, (PaymentTransactionTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





