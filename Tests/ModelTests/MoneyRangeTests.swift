import XCTest
@testable import PayPal

final class MoneyRangeTests: XCTestCase {
    func testInit()throws {
        let range0 = MoneyRange(min: CurrencyCodeAmount(currency: .usd, value: 12.25), max: CurrencyCodeAmount(currency: .usd, value: 50.00))
        XCTAssertEqual(range0.minimum, CurrencyCodeAmount(currency: .usd, value: 12.25))
        XCTAssertEqual(range0.maximum, CurrencyCodeAmount(currency: .usd, value: 50.00))
        
        let range1 = MoneyRange<CurrencyCodeAmount>(12.25...50.00, currency: .usd)
        XCTAssertEqual(range1.minimum, CurrencyCodeAmount(currency: .usd, value: 12.25))
        XCTAssertEqual(range1.maximum, CurrencyCodeAmount(currency: .usd, value: 50.00))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let range = MoneyRange(min: CurrencyCodeAmount(currency: .usd, value: 12.25), max: CurrencyCodeAmount(currency: .usd, value: 50.00))
        let generated = try String(data: encoder.encode(range), encoding: .utf8)
        let json = "{\"minimum_amount\":{\"value\":\"12.25\",\"currency_code\":\"USD\"},\"maximum_amount\":{\"value\":\"50.00\",\"currency_code\":\"USD\"}}"
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "maximum_amount": {
                "value": "50.00",
                "currency_code": "USD"
            },
            "minimum_amount": {
                "value": "12.25",
                "currency_code": "USD"
            }
        }
        """.data(using: .utf8)!
        
        let range = MoneyRange(min: CurrencyCodeAmount(currency: .usd, value: 12.25), max: CurrencyCodeAmount(currency: .usd, value: 50.00))
        try XCTAssertEqual(range, decoder.decode(MoneyRange.self, from: json))
    }
    
    static var allTests: [(String, (MoneyRangeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


