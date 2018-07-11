import XCTest
@testable import PayPal

final class MethodTests: XCTestCase {
    func testCaseRawValues() {
        XCTAssertEqual(Method.GET.rawValue, "GET")
        XCTAssertEqual(Method.POST.rawValue, "POST")
        XCTAssertEqual(Method.PUT.rawValue, "PUT")
        XCTAssertEqual(Method.DELETE.rawValue, "DELETE")
        XCTAssertEqual(Method.HEAD.rawValue, "HEAD")
        XCTAssertEqual(Method.CONNECT.rawValue, "CONNECT")
        XCTAssertEqual(Method.OPTIONS.rawValue, "OPTIONS")
        XCTAssertEqual(Method.PATCH.rawValue, "PATCH")
    }
    
    func testAllCase() {
        XCTAssertEqual(Method.allCases.count, 8)
        XCTAssertEqual(Method.allCases, [.GET, .POST, .PUT, .DELETE, .HEAD, .CONNECT, .OPTIONS, .PATCH])
    }
    
    static var allTests: [(String, (MethodTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase)
    ]
}

