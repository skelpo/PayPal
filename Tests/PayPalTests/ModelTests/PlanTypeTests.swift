import XCTest
@testable import PayPal

final class PlanTypeTests: XCTestCase {
    struct Plan: Codable {
        let type: BillingPlan.PlanType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(BillingPlan.PlanType.fixed.rawValue, "FIXED")
        XCTAssertEqual(BillingPlan.PlanType.infinate.rawValue, "INFINATE")
    }
    
    func testAllCase() {
        XCTAssertEqual(BillingPlan.PlanType.allCases.count, 2)
        XCTAssertEqual(BillingPlan.PlanType.allCases, [.fixed, .infinate])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let fixed = try String(data: encoder.encode(Plan(type: .fixed)), encoding: .utf8)
        let infinate = try String(data: encoder.encode(Plan(type: .infinate)), encoding: .utf8)
        
        XCTAssertEqual(fixed, "{\"type\":\"FIXED\"}")
        XCTAssertEqual(infinate, "{\"type\":\"INFINATE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let fixed = """
        {
            "type": "FIXED"
        }
        """.data(using: .utf8)!
        let infinate = """
        {
            "type": "INFINATE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Plan.self, from: fixed).type, .fixed)
        try XCTAssertEqual(decoder.decode(Plan.self, from: infinate).type, .infinate)
    }
    
    static var allTests: [(String, (PlanTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
