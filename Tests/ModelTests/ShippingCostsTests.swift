import XCTest
@testable import PayPal

final class ShippingCostsTests: XCTestCase {
    func testInit()throws {
        let shipping = ShippingCosts(
            amount: CurrencyAmount(currency: .usd, value: 2.50),
            tax: Tax(name: "Shipping", percent: 7.5, amount: CurrencyAmount(currency: .usd, value: 0.18))
        )
        
        XCTAssertEqual(shipping.amount,  CurrencyAmount(currency: .usd, value: 2.50))
        XCTAssertEqual(shipping.tax, Tax(name: "Shipping", percent: 7.5, amount: CurrencyAmount(currency: .usd, value: 0.18)))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let shipping = ShippingCosts(
            amount: CurrencyAmount(currency: .usd, value: 2.50),
            tax: Tax(name: "Shipping", percent: 7.5, amount: CurrencyAmount(currency: .usd, value: 0.18))
        )
        let generated = try String(data: encoder.encode(shipping), encoding: .utf8)!
        let json =
            "{\"tax\":{\"name\":\"Shipping\",\"percent\":7.5,\"amount\":{\"value\":\"0.18\",\"currency\":\"USD\"}}," +
            "\"amount\":{\"value\":\"2.50\",\"currency\":\"USD\"}}"
        
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
        let shipping = ShippingCosts(
            amount: CurrencyAmount(currency: .usd, value: 2.50),
            tax: Tax(name: "Shipping", percent: 7.5, amount: CurrencyAmount(currency: .usd, value: 0.18))
        )
        
        let json = """
        {
            "tax": {
                "name": "Shipping",
                "percent": 7.5,
                "amount": {
                    "value": "0.18",
                    "currency": "USD"
                }
            },
            "amount": {
                "value": "2.50",
                "currency": "USD"
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(shipping, decoder.decode(ShippingCosts.self, from: json))
    }
    
    static var allTests: [(String, (ShippingCostsTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


