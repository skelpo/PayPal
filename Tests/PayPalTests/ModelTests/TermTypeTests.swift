import XCTest
@testable import PayPal

final class TermTypeTests: XCTestCase {
    struct TaC: Codable {
        let type: TermType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(TermType.weekly.rawValue, "WEEKLY")
        XCTAssertEqual(TermType.monthly.rawValue, "MONTHLY")
        XCTAssertEqual(TermType.yearly.rawValue, "YEARLY")
    }
    
    func testAllCase() {
        XCTAssertEqual(TermType.allCases.count, 3)
        XCTAssertEqual(TermType.allCases, [.weekly, .monthly, .yearly])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let monthly = try String(data: encoder.encode(TaC(type: .monthly)), encoding: .utf8)
        let yearly = try String(data: encoder.encode(TaC(type: .yearly)), encoding: .utf8)
        
        XCTAssertEqual(monthly, "{\"type\":\"MONTHLY\"}")
        XCTAssertEqual(yearly, "{\"type\":\"YEARLY\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let weekly = """
        {
            "type": "WEEKLY"
        }
        """.data(using: .utf8)!
        let yearly = """
        {
            "type": "YEARLY"
        }
        """
        
        try XCTAssertEqual(decoder.decode(TaC.self, from: weekly).type, .weekly)
        try XCTAssertEqual(decoder.decode(TaC.self, from: yearly).type, .yearly)
    }
    
    static var allTests: [(String, (TermTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


