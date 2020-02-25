import XCTest
@testable import PayPal

public final class BillingPlanStateTests: XCTestCase {
    struct Test: Codable {
        let state: BillingPlan.State
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(BillingPlan.State.created.rawValue, "CREATED")
        XCTAssertEqual(BillingPlan.State.active.rawValue, "ACTIVE")
        XCTAssertEqual(BillingPlan.State.inactive.rawValue, "INACTIVE")
        XCTAssertEqual(BillingPlan.State.deleted.rawValue, "DELETED")
    }
    
    func testAllCase() {
        XCTAssertEqual(BillingPlan.State.allCases.count, 4)
        XCTAssertEqual(BillingPlan.State.allCases, [.created, .active, .inactive, .deleted])
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
    
    public static var allTests: [(String, (BillingPlanStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



