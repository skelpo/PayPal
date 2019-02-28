import XCTest
@testable import PayPal

public final class BillingPlanTypeTests: XCTestCase {
    struct Plan: Codable {
        let type: BillingPlan.PlanType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(BillingPlan.PlanType.fixed.rawValue, "FIXED")
        XCTAssertEqual(BillingPlan.PlanType.infinite.rawValue, "INFINITE")
    }
    
    func testAllCase() {
        XCTAssertEqual(BillingPlan.PlanType.allCases.count, 2)
        XCTAssertEqual(BillingPlan.PlanType.allCases, [.fixed, .infinite])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let fixed = try String(data: encoder.encode(Plan(type: .fixed)), encoding: .utf8)
        let infinate = try String(data: encoder.encode(Plan(type: .infinite)), encoding: .utf8)
        
        XCTAssertEqual(fixed, "{\"type\":\"FIXED\"}")
        XCTAssertEqual(infinate, "{\"type\":\"INFINITE\"}")
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
            "type": "INFINITE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Plan.self, from: fixed).type, .fixed)
        try XCTAssertEqual(decoder.decode(Plan.self, from: infinate).type, .infinite)
    }
    
    public static var allTests: [(String, (BillingPlanTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
