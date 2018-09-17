import XCTest
@testable import PayPal

final class OrderItemTests: XCTestCase {
    func testInit()throws {
        let item = try Order.Item(
            sku: "FAE11644-19BC-4643-8215-004C829B19C1",
            name: "Widget",
            description: "It's blue",
            quantity: "5",
            price: "33.33",
            currency: .usd,
            tax: "16.16"
        )
        
        XCTAssertEqual(item.sku, "FAE11644-19BC-4643-8215-004C829B19C1")
        XCTAssertEqual(item.name, "Widget")
        XCTAssertEqual(item.description, "It's blue")
        XCTAssertEqual(item.quantity, "5")
        XCTAssertEqual(item.price, "33.33")
        XCTAssertEqual(item.currency, .usd)
        XCTAssertEqual(item.tax, "16.16")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Order.Item(
            sku: String(repeating: "s", count: 128),
            name: "Widget",
            description: "It's blue",
            quantity: "5",
            price: "33.33",
            currency: .usd,
            tax: "16.16"
        ))
        try XCTAssertThrowsError(Order.Item(
            sku: "FAE11644-19BC-4643-8215-004C829B19C1",
            name: String(repeating: "n", count: 128),
            description: "It's blue",
            quantity: "5",
            price: "33.33",
            currency: .usd,
            tax: "16.16"
        ))
        try XCTAssertThrowsError(Order.Item(
            sku: "FAE11644-19BC-4643-8215-004C829B19C1",
            name: "Widget",
            description: String(repeating: "d", count: 128),
            quantity: "5",
            price: "33.33",
            currency: .usd,
            tax: "16.16"
        ))
        try XCTAssertThrowsError(Order.Item(
            sku: "FAE11644-19BC-4643-8215-004C829B19C1",
            name: "Widget",
            description: "It's blue",
            quantity: "Five",
            price: "33.33",
            currency: .usd,
            tax: "16.16"
        ))
        try XCTAssertThrowsError(Order.Item(
            sku: "FAE11644-19BC-4643-8215-004C829B19C1",
            name: "Widget",
            description: "It's blue",
            quantity: "5",
            price: "33.334",
            currency: .usd,
            tax: "16.16"
        ))
        var item = try Order.Item(
            sku: "FAE11644-19BC-4643-8215-004C829B19C1",
            name: "Widget",
            description: "It's blue",
            quantity: "5",
            price: "33.33",
            currency: .usd,
            tax: "16.16"
        )
        
        try XCTAssertThrowsError(item.set(\Order.Item.sku <~ String(repeating: "s", count: 128)))
        try XCTAssertThrowsError(item.set(\Order.Item.name <~ String(repeating: "n", count: 128)))
        try XCTAssertThrowsError(item.set(\Order.Item.description <~ String(repeating: "d", count: 128)))
        try XCTAssertThrowsError(item.set(\.quantity <~ "Five"))
        try XCTAssertThrowsError(item.set(\.price <~ "33.334"))
        try item.set(\Order.Item.sku <~ String(repeating: "s", count: 127))
        try item.set(\Order.Item.name <~ String(repeating: "n", count: 127))
        try item.set(\Order.Item.description <~ String(repeating: "d", count: 127))
        try item.set(\.quantity <~ "9")
        try item.set(\.price <~ "42.42")
        
        XCTAssertEqual(item.sku, String(repeating: "s", count: 127))
        XCTAssertEqual(item.name, String(repeating: "n", count: 127))
        XCTAssertEqual(item.description, String(repeating: "d", count: 127))
        XCTAssertEqual(item.quantity, "9")
        XCTAssertEqual(item.price, "42.42")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let item = try Order.Item(
            sku: "FAE11644-19BC-4643-8215-004C829B19C1",
            name: "Widget",
            description: "It's blue",
            quantity: "5",
            price: "33.33",
            currency: .usd,
            tax: "16.16"
        )
        let generated = try String(data: encoder.encode(item), encoding: .utf8)!
        let json =
            "{\"quantity\":\"5\",\"sku\":\"FAE11644-19BC-4643-8215-004C829B19C1\",\"price\":\"33.33\",\"tax\":\"16.16\"," +
            "\"description\":\"It's blue\",\"currency\":\"USD\",\"name\":\"Widget\"}"
        
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
            "tax": "16.16",
            "currency": "USD",
            "price": "33.33",
            "quantity": "5",
            "description": "It's blue",
            "name": "Widget",
            "sku": "FAE11644-19BC-4643-8215-004C829B19C1"
        }
        """.data(using: .utf8)!
        let price = """
        {
            "tax": "16.16",
            "currency": "USD",
            "price": "33.334",
            "quantity": "5",
            "description": "It's blue",
            "name": "Widget",
            "sku": "FAE11644-19BC-4643-8215-004C829B19C1"
        }
        """.data(using: .utf8)!
        let quantity = """
        {
            "tax": "16.16",
            "currency": "USD",
            "price": "33.33",
            "quantity": "Five",
            "description": "It's blue",
            "name": "Widget",
            "sku": "FAE11644-19BC-4643-8215-004C829B19C1"
        }
        """.data(using: .utf8)!
        let description = """
        {
            "tax": "16.16",
            "currency": "USD",
            "price": "33.33",
            "quantity": "5",
            "description": "\(String(repeating: "d", count: 128))",
            "name": "Widget",
            "sku": "FAE11644-19BC-4643-8215-004C829B19C1"
        }
        """.data(using: .utf8)!
        let name = """
        {
            "tax": "16.16",
            "currency": "USD",
            "price": "33.33",
            "quantity": "5",
            "description": "It's blue",
            "name": "\(String(repeating: "n", count: 128))",
            "sku": "FAE11644-19BC-4643-8215-004C829B19C1"
        }
        """.data(using: .utf8)!
        let sku = """
        {
            "tax": "16.16",
            "currency": "USD",
            "price": "33.33",
            "quantity": "5",
            "description": "It's blue",
            "name": "Widget",
            "sku": "\(String(repeating: "s", count: 128))"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(Order.Item.self, from: price))
        try XCTAssertThrowsError(decoder.decode(Order.Item.self, from: quantity))
        try XCTAssertThrowsError(decoder.decode(Order.Item.self, from: description))
        try XCTAssertThrowsError(decoder.decode(Order.Item.self, from: name))
        try XCTAssertThrowsError(decoder.decode(Order.Item.self, from: sku))
        try XCTAssertEqual(decoder.decode(Order.Item.self, from: json), Order.Item(
            sku: "FAE11644-19BC-4643-8215-004C829B19C1",
            name: "Widget",
            description: "It's blue",
            quantity: "5",
            price: "33.33",
            currency: .usd,
            tax: "16.16"
        ))
    }
    
    static var allTests: [(String, (OrderItemTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





