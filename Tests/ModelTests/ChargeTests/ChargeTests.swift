import XCTest
@testable import PayPal

public final class ChargeTests: XCTestCase {
    func testInit()throws {
        let charge = Charge(type: .shipping, amount: CurrencyCodeAmount(currency: .usd, value: 314.15))
        
        XCTAssertEqual(charge.id, nil)
        XCTAssertEqual(charge.type, .shipping)
        XCTAssertEqual(charge.amount, CurrencyCodeAmount(currency: .usd, value: 314.15))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(Charge(type: .shipping, amount: CurrencyCodeAmount(currency: .eur, value: 314.15))), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"type\":\"SHIPPING\",\"amount\":{\"value\":\"314.15\",\"currency_code\":\"EUR\"}}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "type": "TAX",
            "amount": {
                "value": "13.54",
                "currency_code": "EUR"
            }
        }
        """.data(using: .utf8)!

        let value = Decimal(sign: .plus, exponent: -2, significand: 1354)
        try XCTAssertEqual(Charge(type: .tax, amount: CurrencyCodeAmount(currency: .eur, value: value)), decoder.decode(Charge.self, from: json))
    }
    
    static var allTests: [(String, (ChargeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

