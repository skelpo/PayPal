import XCTest
@testable import PayPal

final class PlanStateTests: XCTestCase {
    struct Test: Codable {
        let state: PlanState
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(PlanState.created.rawValue, "CREATED")
        XCTAssertEqual(PlanState.active.rawValue, "ACTIVE")
        XCTAssertEqual(PlanState.inactive.rawValue, "INACTIVE")
        XCTAssertEqual(PlanState.deleted.rawValue, "DELETED")
    }
    
    func testAllCase() {
        XCTAssertEqual(PlanState.allCases.count, 4)
        XCTAssertEqual(PlanState.allCases, [.created, .active, .inactive, .deleted])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let created = try String(data: encoder.encode(Test(state: .created)), encoding: .utf8)
        let active = try String(data: encoder.encode(Test(state: .active)), encoding: .utf8)
        
        XCTAssertEqual(created, "{\"state\":\"CREATED\"}")
        XCTAssertEqual(active, "{\"state\":\"ACTIVE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let inactive = """
        {
            "state": "INACTIVE"
        }
        """.data(using: .utf8)!
        let deleted = """
        {
            "state": "DELETED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Test.self, from: inactive).state, .inactive)
        try XCTAssertEqual(decoder.decode(Test.self, from: deleted).state, .deleted)
    }
    
    static var allTests: [(String, (PlanStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



