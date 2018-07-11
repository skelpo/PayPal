import XCTest
@testable import PayPal

final class RoleTests: XCTestCase {
    func testCaseRawValues() {
        XCTAssertEqual(Role.requester.rawValue, "REQUESTER")
        XCTAssertEqual(Role.requestee.rawValue, "REQUESTEE")
        XCTAssertEqual(Role.payer.rawValue, "PAYER")
        XCTAssertEqual(Role.payee.rawValue, "PAYEE")
    }
    
    func testAllCase() {
        XCTAssertEqual(Role.allCases.count, 4)
        XCTAssertEqual(Role.allCases, [.requester, .requestee, .payer, .payee])
    }
    
    static var allTests: [(String, (RoleTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase)
    ]
}


