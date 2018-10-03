import XCTest
@testable import PayPal

final class AccountTypeTests: XCTestCase {
    struct Account: Codable {
        let type: UserInfo.AccountType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(UserInfo.AccountType.personal.rawValue, "PERSONAL")
        XCTAssertEqual(UserInfo.AccountType.business.rawValue, "BUSINESS")
        XCTAssertEqual(UserInfo.AccountType.premier.rawValue, "PREMIER")
    }
    
    func testAllCase() {
        XCTAssertEqual(UserInfo.AccountType.allCases.count, 3)
        XCTAssertEqual(UserInfo.AccountType.allCases, [.personal, .business, .premier])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let personal = try String(data: encoder.encode(Account(type: .personal)), encoding: .utf8)
        let business = try String(data: encoder.encode(Account(type: .business)), encoding: .utf8)
        
        XCTAssertEqual(personal, "{\"type\":\"PERSONAL\"}")
        XCTAssertEqual(business, "{\"type\":\"BUSINESS\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let premier = """
        {
            "type": "PREMIER"
        }
        """.data(using: .utf8)!
        let personal = """
        {
            "type": "PERSONAL"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Account.self, from: premier).type, .premier)
        try XCTAssertEqual(decoder.decode(Account.self, from: personal).type, .personal)
    }
    
    static var allTests: [(String, (AccountTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

