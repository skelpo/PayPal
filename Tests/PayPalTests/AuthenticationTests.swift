import XCTest
@testable import PayPal

final class AuthenticationTests: XCTestCase {
    func testTokenExpired() {
        let info = AuthInfo()
        XCTAssert(info.tokenExpired == true)
    }
    
    static var allTests: [(String, (AuthenticationTests) -> ()throws -> ())] = [
        ("testTokenExpired", testTokenExpired)
    ]
}

