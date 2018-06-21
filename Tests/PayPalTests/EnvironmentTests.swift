import XCTest
@testable import PayPal

final class EnvironmentTests: XCTestCase {
    func testCaseRawValues() {
        XCTAssertEqual(Environment.production.rawValue, "production")
        XCTAssertEqual(Environment.sandbox.rawValue, "sandbox")
    }
    
    static var allTests: [(String, (EnvironmentTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues)
    ]
}

