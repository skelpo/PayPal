import XCTest
@testable import PayPal

final class MoneyRangeTests: XCTestCase {
    func testInit()throws {
        let range0 = try MoneyRange(min: Money(currency: .usd, value: "12.25"), max: Money(currency: .usd, value: "50.00"))
        try XCTAssertEqual(range0.minimum, Money(currency: .usd, value: "12.25"))
        try XCTAssertEqual(range0.maximum, Money(currency: .usd, value: "50.00"))
        
        let range1 = try MoneyRange<Money>("12.25"..."50.00", currency: .usd)
        try XCTAssertEqual(range1.minimum, Money(currency: .usd, value: "12.25"))
        try XCTAssertEqual(range1.maximum, Money(currency: .usd, value: "50.00"))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let range = try MoneyRange(min: Money(currency: .usd, value: "12.25"), max: Money(currency: .usd, value: "50.00"))
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
        
        let range = try MoneyRange(min: Money(currency: .usd, value: "12.25"), max: Money(currency: .usd, value: "50.00"))
        try XCTAssertEqual(range, decoder.decode(MoneyRange.self, from: json))
    }
    
    static var allTests: [(String, (MoneyRangeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


