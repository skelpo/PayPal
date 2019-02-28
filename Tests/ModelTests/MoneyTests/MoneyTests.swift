import XCTest
@testable import PayPal

public final class MoneyTests: XCTestCase {
    func testInit()throws {
        let amount = CurrencyAmount(currency: .aud, value: 10.25)
        
        XCTAssertEqual(amount.currency, .aud)
        XCTAssertEqual(amount.value, 10.25)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let usd = try String(data: encoder.encode(CurrencyCodeAmount(currency: .usd, value: 12.2471)), encoding: .utf8)
        let xxx = try String(data: encoder.encode(CurrencyCodeAmount(currency: .xxx, value: 0)), encoding: .utf8)
        let eur = try String(data: encoder.encode(CurrencyCodeAmount(currency: .eur, value: 4.5)), encoding: .utf8)
        
        let usdO = try String(data: encoder.encode(CurrencyCodeAmount(currency: .usd, value: 0)), encoding: .utf8)
        
        XCTAssertEqual(usd, "{\"value\":\"12.25\",\"currency_code\":\"USD\"}")
        XCTAssertEqual(xxx, "{\"value\":\"0\",\"currency_code\":\"XXX\"}")
        XCTAssertEqual(eur, "{\"value\":\"4.50\",\"currency_code\":\"EUR\"}")
        
        XCTAssertEqual(usdO, "{\"value\":\"0.00\",\"currency_code\":\"USD\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let codeFail = """
        {
            "value": "44.54",
            "currency_code": "EEE"
        }
        """.data(using: .utf8)!
        let valueParse = """
        {
            "value": "33.y",
            "currency_code": "USD"
        }
        """.data(using: .utf8)!
        let valid = """
        {
            "currency_code": "EUR",
            "value": "50.52"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(CurrencyCodeAmount.self, from: codeFail))
        try XCTAssertEqual(CurrencyCodeAmount(currency: .eur, value: 50.52), decoder.decode(CurrencyCodeAmount.self, from: valid))
        try XCTAssertEqual(CurrencyCodeAmount(currency: .usd, value: 33), decoder.decode(CurrencyCodeAmount.self, from: valueParse))
    }
    
    static var allTests: [(String, (MoneyTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

