import XCTest
@testable import PayPal

public final class AgreementStateTests: XCTestCase {
    struct Agree: Codable {
        let state: AgreementState
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(AgreementState.pending.rawValue, "Pending")
        XCTAssertEqual(AgreementState.active.rawValue, "Active")
        XCTAssertEqual(AgreementState.suspended.rawValue, "Suspended")
        XCTAssertEqual(AgreementState.cancelled.rawValue, "Cancelled")
        XCTAssertEqual(AgreementState.expired.rawValue, "Expired")
    }
    
    func testAllCase() {
        XCTAssertEqual(AgreementState.allCases.count, 5)
        XCTAssertEqual(AgreementState.allCases, [.pending, .active, .suspended, .cancelled, .expired])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let pending = try String(data: encoder.encode(Agree(state: .pending)), encoding: .utf8)
        let active = try String(data: encoder.encode(Agree(state: .active)), encoding: .utf8)
        
        XCTAssertEqual(pending, "{\"state\":\"Pending\"}")
        XCTAssertEqual(active, "{\"state\":\"Active\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let cancelled = """
        {
            "state": "Cancelled"
        }
        """.data(using: .utf8)!
        let expired = """
        {
            "state": "Expired"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Agree.self, from: cancelled).state, .cancelled)
        try XCTAssertEqual(decoder.decode(Agree.self, from: expired).state, .expired)
    }
    
    public static var allTests: [(String, (AgreementStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



