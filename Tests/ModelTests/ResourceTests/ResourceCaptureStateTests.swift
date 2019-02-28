import XCTest
@testable import PayPal

fileprivate typealias State = RelatedResource.Capture.State

public final class ResourceCaptureStateTests: XCTestCase {
    private struct Capture: Codable {
        let state: State
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(State.pending.rawValue, "pending")
        XCTAssertEqual(State.completed.rawValue, "completed")
        XCTAssertEqual(State.refunded.rawValue, "refunded")
        XCTAssertEqual(State.partiallyRefunded.rawValue, "partially_refunded")
        XCTAssertEqual(State.denied.rawValue, "denied")
    }
    
    func testAllCase() {
        XCTAssertEqual(State.allCases.count, 5)
        XCTAssertEqual(State.allCases, [.pending, .completed, .refunded, .partiallyRefunded, .denied])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let pending = try String(data: encoder.encode(Capture(state: .pending)), encoding: .utf8)
        let completed = try String(data: encoder.encode(Capture(state: .completed)), encoding: .utf8)
        
        XCTAssertEqual(pending, "{\"state\":\"pending\"}")
        XCTAssertEqual(completed, "{\"state\":\"completed\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let refunded = """
        {
            "state": "refunded"
        }
        """.data(using: .utf8)!
        let partiallyRefunded = """
        {
            "state": "partially_refunded"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Capture.self, from: refunded).state, .refunded)
        try XCTAssertEqual(decoder.decode(Capture.self, from: partiallyRefunded).state, .partiallyRefunded)
    }
    
    static var allTests: [(String, (ResourceCaptureStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}











