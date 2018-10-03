import XCTest
@testable import PayPal

fileprivate typealias State = RelatedResource.Authorization.State

final class ResourceAuthorizationStateTests: XCTestCase {
    private struct Auth: Codable {
        let state: State
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(State.pending.rawValue, "pending")
        XCTAssertEqual(State.authorized.rawValue, "authorized")
        XCTAssertEqual(State.partiallyCaptured.rawValue, "partially_captured")
        XCTAssertEqual(State.captured.rawValue, "captured")
        XCTAssertEqual(State.expired.rawValue, "expired")
        XCTAssertEqual(State.voided.rawValue, "voided")
    }
    
    func testAllCase() {
        XCTAssertEqual(State.allCases.count, 6)
        XCTAssertEqual(State.allCases, [.pending, .authorized, .partiallyCaptured, .captured, .expired, .voided])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let pending = try String(data: encoder.encode(Auth(state: .pending)), encoding: .utf8)
        let authorized = try String(data: encoder.encode(Auth(state: .authorized)), encoding: .utf8)
        
        XCTAssertEqual(pending, "{\"state\":\"pending\"}")
        XCTAssertEqual(authorized, "{\"state\":\"authorized\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let partiallyCaptured = """
        {
            "state": "partially_captured"
        }
        """.data(using: .utf8)!
        let captured = """
        {
            "state": "captured"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Auth.self, from: partiallyCaptured).state, .partiallyCaptured)
        try XCTAssertEqual(decoder.decode(Auth.self, from: captured).state, .captured)
    }
    
    static var allTests: [(String, (ResourceAuthorizationStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}










