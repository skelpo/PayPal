import XCTest
@testable import PayPal

final class CurrencyTests: XCTestCase {
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
    
    static var allTests: [(String, (CurrencyTests) -> ()throws -> ())] = [
        ("testFindByCode", testFindByCode),
        ("testAllCasesSpeed", testAllCasesSpeed)
    ]
}
