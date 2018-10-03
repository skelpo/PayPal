import XCTest
@testable import PayPal

final class DiscountTests: XCTestCase {
    func testInit()throws {
        let discount = try Discount(percent: 15, amount: Amount(currency: .usd, value: "1.25"))
        
        XCTAssertEqual(discount.percent, 15)
        try XCTAssertEqual(discount.amount, Amount(currency: .usd, value: "1.25"))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let discount = try Discount(percent: 15, amount: Amount(currency: .usd, value: "1.25"))
        let json = try String(data: encoder.encode(discount), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"percent\":15,\"amount\":{\"value\":\"1.25\",\"currency\":\"USD\"}}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "percent": 15,
            "amount": {
                "value": "1.25",
                "currency": "USD"
            }
        }
        """.data(using: .utf8)!
        
        let discount = try Discount(percent: 15, amount: Amount(currency: .usd, value: "1.25"))
        try XCTAssertEqual(discount, decoder.decode(Discount<Amount>.self, from: json))
    }
    
    static var allTests: [(String, (DiscountTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


