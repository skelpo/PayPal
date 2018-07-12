import XCTest
@testable import PayPal

final class PlanTypeTests: XCTestCase {
    struct Plan: Codable {
        let type: PlanType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(PlanType.fixed.rawValue, "FIXED")
        XCTAssertEqual(PlanType.infinate.rawValue, "INFINATE")
    }
    
    func testAllCase() {
        XCTAssertEqual(PlanType.allCases.count, 2)
        XCTAssertEqual(PlanType.allCases, [.fixed, .infinate])
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
