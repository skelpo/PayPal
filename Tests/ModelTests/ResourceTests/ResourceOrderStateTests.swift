import XCTest
@testable import PayPal

fileprivate typealias State = RelatedResource.Order.State

final class ResourceOrderStateTests: XCTestCase {
    private struct Order: Codable {
        let state: State
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(State.pending.rawValue, "pending")
        XCTAssertEqual(State.authorized.rawValue, "authorized")
        XCTAssertEqual(State.captured.rawValue, "captured")
        XCTAssertEqual(State.completed.rawValue, "completed")
        XCTAssertEqual(State.voided.rawValue, "voided")
    }
    
    func testAllCase() {
        XCTAssertEqual(State.allCases.count, 5)
        XCTAssertEqual(State.allCases, [.pending, .authorized, .captured, .completed, .voided])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let pending = try String(data: encoder.encode(Order(state: .pending)), encoding: .utf8)
        let authorized = try String(data: encoder.encode(Order(state: .authorized)), encoding: .utf8)
        
        XCTAssertEqual(pending, "{\"state\":\"pending\"}")
        XCTAssertEqual(authorized, "{\"state\":\"authorized\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let completed = """
        {
            "state": "completed"
        }
        """.data(using: .utf8)!
        let captured = """
        {
            "state": "captured"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Order.self, from: completed).state, .completed)
        try XCTAssertEqual(decoder.decode(Order.self, from: captured).state, .captured)
    }
    
    static var allTests: [(String, (ResourceOrderStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
