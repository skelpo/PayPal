import XCTest
@testable import PayPal

typealias RefStat = Refund.Status

public final class RefundStatusTests: XCTestCase {
    struct Ref: Codable {
        let status: RefStat
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(RefStat.pending.rawValue, "PENDING")
        XCTAssertEqual(RefStat.completed.rawValue, "COMPLETED")
        XCTAssertEqual(RefStat.failed.rawValue, "FAILED")
    }
    
    func testAllCase() {
        XCTAssertEqual(RefStat.allCases.count, 3)
        XCTAssertEqual(RefStat.allCases, [.pending, .completed, .failed])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let pending = try String(data: encoder.encode(Ref(status: .pending)), encoding: .utf8)
        let completed = try String(data: encoder.encode(Ref(status: .completed)), encoding: .utf8)
        
        XCTAssertEqual(pending, "{\"status\":\"PENDING\"}")
        XCTAssertEqual(completed, "{\"status\":\"COMPLETED\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let failed = """
        {
            "status": "FAILED"
        }
        """.data(using: .utf8)!
        let pending = """
        {
            "status": "PENDING"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Ref.self, from: failed).status, .failed)
        try XCTAssertEqual(decoder.decode(Ref.self, from: pending).status, .pending)
    }
    
    public static var allTests: [(String, (RefundStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






