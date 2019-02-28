import XCTest
import Failable
@testable import PayPal

public final class PaymentItemTests: XCTestCase {
    func testInit()throws {
        let item = try Payment.Item(
            quantity: .init(3), price: .init(2.50), currency: .usd, sku: .init("123456"), name: .init("Foo"),
            description: .init("Foo Bar"), tax: "0.25"
        )
        
        XCTAssertEqual(item.quantity.value, 3)
        XCTAssertEqual(item.price.value, 2.50)
        XCTAssertEqual(item.currency, .usd)
        XCTAssertEqual(item.sku.value, "123456")
        XCTAssertEqual(item.name.value, "Foo")
        XCTAssertEqual(item.description.value, "Foo Bar")
        XCTAssertEqual(item.tax, "0.25")
    }
    
    func testValidations()throws {
        var item = try Payment.Item(
            quantity: .init(3), price: .init(2.50), currency: .usd, sku: .init("123456"), name: .init("Foo"),
            description: .init("Foo Bar"), tax: "0.25"
        )
        
        try XCTAssertThrowsError(item.quantity <~ 12345678900)
        try XCTAssertThrowsError(item.price <~ 12345678900.00)
        try XCTAssertThrowsError(item.sku <~ String(repeating: "s", count: 128))
        try XCTAssertThrowsError(item.name <~ String(repeating: "n", count: 128))
        try XCTAssertThrowsError(item.description <~ String(repeating: "d", count: 128))
        try item.quantity <~ 1234567890
        try item.price <~ 12345678.0
        try item.sku <~ String(repeating: "s", count: 127)
        try item.name <~ String(repeating: "n", count: 127)
        try item.description <~ String(repeating: "d", count: 127)
        
        
        XCTAssertEqual(item.quantity.value, 1234567890)
        XCTAssertEqual(item.price.value, 12345678.0)
        XCTAssertEqual(item.sku.value, String(repeating: "s", count: 127))
        XCTAssertEqual(item.name.value, String(repeating: "n", count: 127))
        XCTAssertEqual(item.description.value, String(repeating: "d", count: 127))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let item = try Payment.Item(
            quantity: .init(3), price: .init(2.50), currency: .usd, sku: .init("123456"), name: .init("Foo"),
            description: .init("Foo Bar"), tax: "0.25"
        )
        let generated = try String(data: encoder.encode(item), encoding: .utf8)!
        let json =
            "{\"quantity\":\"3\",\"sku\":\"123456\",\"tax\":\"0.25\",\"price\":\"2.5\",\"description\":\"Foo Bar\",\"currency\":\"USD\"," +
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
        
        let item = try Payment.Item(
            quantity: .init(3), price: .init(2.50), currency: .usd, sku: .init("123456"), name: .init("Foo"),
            description: .init("Foo Bar"), tax: "0.25"
        )
        try XCTAssertEqual(item, decoder.decode(Payment.Item.self, from: json))
    }
    
    static var allTests: [(String, (PaymentItemTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





