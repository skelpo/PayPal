import XCTest
@testable import PayPal

fileprivate typealias Type = FraudManagementFilter.FilterType

public final class FraudManagementFilterTypeTests: XCTestCase {
    private struct Instrument: Codable {
        let type: Type
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Type.accept.rawValue, "ACCEPT")
        XCTAssertEqual(Type.pending.rawValue, "PENDING")
        XCTAssertEqual(Type.deny.rawValue, "DENY")
        XCTAssertEqual(Type.report.rawValue, "REPORT")
    }
    
    func testAllCase() {
        XCTAssertEqual(Type.allCases.count, 4)
        XCTAssertEqual(Type.allCases, [.accept, .pending, .deny, .report])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let accept = try String(data: encoder.encode(Instrument(type: .accept)), encoding: .utf8)
        let pending = try String(data: encoder.encode(Instrument(type: .pending)), encoding: .utf8)
        
        XCTAssertEqual(accept, "{\"type\":\"ACCEPT\"}")
        XCTAssertEqual(pending, "{\"type\":\"PENDING\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let deny = """
        {
            "type": "DENY"
        }
        """.data(using: .utf8)!
        let report = """
        {
            "type": "REPORT"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Instrument.self, from: deny).type, .deny)
        try XCTAssertEqual(decoder.decode(Instrument.self, from: report).type, .report)
    }
    
    static var allTests: [(String, (FraudManagementFilterTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





