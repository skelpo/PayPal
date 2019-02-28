import XCTest
@testable import PayPal

fileprivate typealias State = RelatedResource.Refund.State

public final class ResourceRefundStateTests: XCTestCase {
    private struct Order: Codable {
        let state: State
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(State.pending.rawValue, "pending")
        XCTAssertEqual(State.completed.rawValue, "completed")
        XCTAssertEqual(State.cancelled.rawValue, "cancelled")
        XCTAssertEqual(State.failed.rawValue, "failed")
    }
    
    func testAllCase() {
        XCTAssertEqual(State.allCases.count, 4)
        XCTAssertEqual(State.allCases, [.pending, .completed, .cancelled, .failed])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let pending = try String(data: encoder.encode(Order(state: .pending)), encoding: .utf8)
        let completed = try String(data: encoder.encode(Order(state: .completed)), encoding: .utf8)
        
        XCTAssertEqual(pending, "{\"state\":\"pending\"}")
        XCTAssertEqual(completed, "{\"state\":\"completed\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let cancelled = """
        {
            "state": "cancelled"
        }
        """.data(using: .utf8)!
        let failed = """
        {
            "state": "failed"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Order.self, from: cancelled).state, .cancelled)
        try XCTAssertEqual(decoder.decode(Order.self, from: failed).state, .failed)
    }
    
    static var allTests: [(String, (ResourceRefundStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

