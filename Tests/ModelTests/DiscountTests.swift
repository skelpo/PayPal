import XCTest
@testable import PayPal

public final class DiscountTests: XCTestCase {
    func testInit()throws {
        let discount = Discount(percent: 15, amount: CurrencyAmount(currency: .usd, value: 1.25))
        
        XCTAssertEqual(discount.percent, 15)
        XCTAssertEqual(discount.amount, CurrencyAmount(currency: .usd, value: 1.25))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let discount = Discount(percent: 15, amount: CurrencyAmount(currency: .usd, value: 1.25))
        let json = try String(data: encoder.encode(discount), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"percent\":15,\"amount\":{\"currency\":\"USD\",\"value\":\"1.25\"}}")
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
        
        let discount = Discount(percent: 15, amount: CurrencyAmount(currency: .usd, value: 1.25))
        try XCTAssertEqual(discount, decoder.decode(Discount<CurrencyAmount>.self, from: json))
    }
    
    public static var allTests: [(String, (DiscountTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


