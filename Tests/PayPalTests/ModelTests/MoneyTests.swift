import XCTest
@testable import PayPal

final class MoneyTests: XCTestCase {
    func testValueValidation()throws {
        try XCTAssertThrowsError(Money(currency: .usd, value: String(repeating: "1", count: 33)))
        try XCTAssertThrowsError(Money(currency: .usd, value: "1945r"))
        try XCTAssertThrowsError(Money(currency: .usd, value: "88*99"))
        
        var test = try Money(currency: .ang, value: "-32.4")
        XCTAssertEqual(test.currency, .ang)
        XCTAssertEqual(test.value, "-32.4")
        
        test.currency = .xxx
        try test.set(\.value <~ "88")
        XCTAssertEqual(test.value, "88")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let usd = try String(data: encoder.encode(Money(currency: .usd, value: "12.25")), encoding: .utf8)
        let xxx = try String(data: encoder.encode(Money(currency: .xxx, value: "0")), encoding: .utf8)
        let eur = try String(data: encoder.encode(Money(currency: .eur, value: "4.5")), encoding: .utf8)
        
        XCTAssertEqual(usd, "{\"value\":\"12.25\",\"currency_code\":\"USD\"}")
        XCTAssertEqual(xxx, "{\"value\":\"0\",\"currency_code\":\"XXX\"}")
        XCTAssertEqual(eur, "{\"value\":\"4.5\",\"currency_code\":\"EUR\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let codeFail = """
        {
            "value": "44.54",
            "currency_code": "EEE"
        }
        """.data(using: .utf8)!
        let valueFail = """
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
        
        try XCTAssertThrowsError(decoder.decode(Money.self, from: codeFail))
        try XCTAssertThrowsError(decoder.decode(Money.self, from: valueFail))
        try XCTAssertEqual(Money(currency: .eur, value: "50.52"), decoder.decode(Money.self, from: valid))
    }
    
    static var allTests: [(String, (MoneyTests) -> ()throws -> ())] = [
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

