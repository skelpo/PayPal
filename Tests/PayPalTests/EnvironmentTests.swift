import XCTest
@testable import PayPal

final class EnvironmentTests: XCTestCase {
    func testCaseRawValues() {
        XCTAssertEqual(Environment.production.rawValue, "production")
        XCTAssertEqual(Environment.sandbox.rawValue, "sandbox")
    }
    
    func testCaseDomains() {
        XCTAssertEqual(Environment.production.domain, "https://api.paypal.com")
        XCTAssertEqual(Environment.sandbox.domain, "https://api.sandbox.paypal.com")
    }
    
    func testAllCase() {
        XCTAssertEqual(Environment.allCases, [.sandbox, .production])
    }
    
    static var allTests: [(String, (EnvironmentTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testCaseDomains", testCaseDomains),
        ("testAllCase", testAllCase)
    ]
}

