import XCTest
@testable import PayPal

fileprivate typealias State = Payment.RefundResult.State

final class PaymentRefundStateTests: XCTestCase {
    private struct Result: Codable {
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
        let pending = try String(data: encoder.encode(Result(state: .pending)), encoding: .utf8)
        let completed = try String(data: encoder.encode(Result(state: .completed)), encoding: .utf8)
        
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
        """
        
        try XCTAssertEqual(decoder.decode(Result.self, from: cancelled).state, .cancelled)
        try XCTAssertEqual(decoder.decode(Result.self, from: failed).state, .failed)
    }
    
    static var allTests: [(String, (PaymentRefundStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

