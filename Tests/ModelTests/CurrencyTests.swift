import XCTest
@testable import PayPal

public final class CurrencyTests: XCTestCase {
    struct Model: Codable, Equatable {
        var cur: Currency
    }
    
    func testFindByCode() {
        XCTAssertEqual(Currency(code: "USD"), Currency(code: "USD", number: 840, e: 2, name: "United States dollar"))
        XCTAssertEqual(Currency(code: "XXX"), Currency(code: "XXX", number: 999, e: nil, name: "No currency"))
        XCTAssertEqual(Currency(code: "EUR"), Currency(code: "EUR", number: 978, e: 2, name: "Euro"))
        
        measure {
            for _ in 0...1_000_000 {
                _ = Currency(code: "XXX")
            }
        }
    }
    
    func testAllCasesSpeed() {
        measure {
            for _ in 0...1_000_000 {
                _ = Currency.allCases
            }
        }
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let usd = try String(data: encoder.encode(Model(cur: Currency.usd)), encoding: .utf8)
        let xxx = try String(data: encoder.encode(Model(cur: Currency.xxx)), encoding: .utf8)
        let eur = try String(data: encoder.encode(Model(cur: Currency.eur)), encoding: .utf8)
        
        XCTAssertEqual(usd, "{\"cur\":\"USD\"}")
        XCTAssertEqual(xxx, "{\"cur\":\"XXX\"}")
        XCTAssertEqual(eur, "{\"cur\":\"EUR\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let custom = """
        {
            "code": "XYZ",
            "number": 998,
            "name": "Xavier's Youthful Zillions"
        }
        """.data(using: .utf8)!
        let existing = """
        {
            "cur": "ZWL"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Currency.self, from: custom), Currency(code: "XYZ", number: 998, e: nil, name: "Xavier's Youthful Zillions"))
        try XCTAssertEqual(decoder.decode(Model.self, from: existing), Model(cur: .zwl))
    }
    
    public static var allTests: [(String, (CurrencyTests) -> ()throws -> ())] = [
        ("testFindByCode", testFindByCode),
        ("testAllCasesSpeed", testAllCasesSpeed),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
