import XCTest
@testable import PayPal

final class AccountStatusTests: XCTestCase {
    struct Account: Codable {
        let status: AccountStatus
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(AccountStatus.a.rawValue, "A")
        XCTAssertEqual(AccountStatus.pv.rawValue, "PV")
        XCTAssertEqual(AccountStatus.pua.rawValue, "PUA")
    }
    
    func testAllCase() {
        XCTAssertEqual(AccountStatus.allCases.count, 3)
        XCTAssertEqual(AccountStatus.allCases, [.a, .pv, .pua])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let a = try String(data: encoder.encode(Account(status: .a)), encoding: .utf8)
        let pv = try String(data: encoder.encode(Account(status: .pv)), encoding: .utf8)
        
        XCTAssertEqual(a, "{\"status\":\"A\"}")
        XCTAssertEqual(pv, "{\"status\":\"PV\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let pv = """
        {
            "status": "PV"
        }
        """.data(using: .utf8)!
        let pua = """
        {
            "status": "PUA"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Account.self, from: pv).status, .pv)
        try XCTAssertEqual(decoder.decode(Account.self, from: pua).status, .pua)
    }
    
    static var allTests: [(String, (AccountStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




