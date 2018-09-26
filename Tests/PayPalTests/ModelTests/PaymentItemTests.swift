import XCTest
@testable import PayPal

final class PaymentItemTests: XCTestCase {
    func testInit()throws {
        let item = try Payment.Item(quantity: "3", price: "2.50", currency: .usd, sku: "123456", name: "Foo", description: "Foo Bar", tax: "0.25")
        
        XCTAssertEqual(item.quantity, "3")
        XCTAssertEqual(item.price, "2.50")
        XCTAssertEqual(item.currency, .usd)
        XCTAssertEqual(item.sku, "123456")
        XCTAssertEqual(item.name, "Foo")
        XCTAssertEqual(item.description, "Foo Bar")
        XCTAssertEqual(item.tax, "0.25")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Payment.Item(quantity: "12345678900", price: "2", currency: .usd, sku: nil, name: nil, description: nil, tax: nil))
        try XCTAssertThrowsError(Payment.Item(quantity: "3", price: "123456789.00", currency: .usd, sku: nil, name: nil, description: nil, tax: nil))
        try XCTAssertThrowsError(
            Payment.Item(quantity: "3", price: "2", currency: .usd, sku: String(repeating: "s", count: 128), name: nil, description: nil, tax: nil)
        )
        try XCTAssertThrowsError(
            Payment.Item(quantity: "3", price: "2", currency: .usd, sku: nil, name: String(repeating: "n", count: 128), description: nil, tax: nil)
        )
        try XCTAssertThrowsError(
            Payment.Item(quantity: "3", price: "2", currency: .usd, sku: nil, name: nil, description: String(repeating: "d", count: 128), tax: nil)
        )
        var item = try Payment.Item(quantity: "3", price: "2.50", currency: .usd, sku: "123456", name: "Foo", description: "Foo Bar", tax: "0.25")
        
        try XCTAssertThrowsError(item.set(\.quantity <~ "12345678900"))
        try XCTAssertThrowsError(item.set(\.price <~ "123456789.00"))
        try XCTAssertThrowsError(item.set(\Payment.Item.sku <~ String(repeating: "s", count: 128)))
        try XCTAssertThrowsError(item.set(\Payment.Item.name <~ String(repeating: "n", count: 128)))
        try XCTAssertThrowsError(item.set(\Payment.Item.description <~ String(repeating: "d", count: 128)))
        try item.set(\.quantity <~ "1234567890")
        try item.set(\.price <~ "12345678.0")
        try item.set(\Payment.Item.sku <~ String(repeating: "s", count: 127))
        try item.set(\Payment.Item.name <~ String(repeating: "n", count: 127))
        try item.set(\Payment.Item.description <~ String(repeating: "d", count: 127))
        
        
        XCTAssertEqual(item.quantity, "1234567890")
        XCTAssertEqual(item.price, "12345678.0")
        XCTAssertEqual(item.sku, String(repeating: "s", count: 127))
        XCTAssertEqual(item.name, String(repeating: "n", count: 127))
        XCTAssertEqual(item.description, String(repeating: "d", count: 127))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let item = try Payment.Item(quantity: "3", price: "2.50", currency: .usd, sku: "123456", name: "Foo", description: "Foo Bar", tax: "0.25")
        let generated = try String(data: encoder.encode(item), encoding: .utf8)!
        let json =
            "{\"quantity\":\"3\",\"sku\":\"123456\",\"tax\":\"0.25\",\"price\":\"2.50\",\"description\":\"Foo Bar\",\"currency\":\"USD\"," +
            "\"name\":\"Foo\"}"
        
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
            "quantity": "3",
            "price": "2.50",
            "currency": "USD",
            "sku": "123456",
            "name": "Foo",
            "description": "Foo Bar",
            "tax": "0.25"
        }
        """.data(using: .utf8)!
        
        let item = try Payment.Item(quantity: "3", price: "2.50", currency: .usd, sku: "123456", name: "Foo", description: "Foo Bar", tax: "0.25")
        try XCTAssertEqual(item, decoder.decode(Payment.Item.self, from: json))
    }
    
    static var allTests: [(String, (PaymentItemTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





