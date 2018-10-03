import XCTest
@testable import PayPal

final class RoleTests: XCTestCase {
    struct User: Codable {
        let role: Role
    }
    
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
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let requester = try String(data: encoder.encode(User(role: .requester)), encoding: .utf8)
        let payee = try String(data: encoder.encode(User(role: .payee)), encoding: .utf8)
        
        XCTAssertEqual(requester, "{\"role\":\"REQUESTER\"}")
        XCTAssertEqual(payee, "{\"role\":\"PAYEE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let requestee = """
        {
            "role": "REQUESTEE"
        }
        """.data(using: .utf8)!
        let payer = """
        {
            "role": "PAYER"
        }
        """
        
        try XCTAssertEqual(decoder.decode(User.self, from: requestee).role, .requestee)
        try XCTAssertEqual(decoder.decode(User.self, from: payer).role, .payer)
    }
    
    static var allTests: [(String, (RoleTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


