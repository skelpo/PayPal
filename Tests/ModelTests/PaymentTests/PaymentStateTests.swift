import XCTest
@testable import PayPal

fileprivate typealias State = Payment.State

public final class PaymentStateTests: XCTestCase {
    private struct Pay: Codable {
        let state: State
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(State.created.rawValue, "created")
        XCTAssertEqual(State.approved.rawValue, "approved")
        XCTAssertEqual(State.failed.rawValue, "failed")
    }
    
    func testAllCase() {
        XCTAssertEqual(State.allCases.count, 3)
        XCTAssertEqual(State.allCases, [.created, .approved, .failed])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let created = try String(data: encoder.encode(Pay(state: .created)), encoding: .utf8)
        let approved = try String(data: encoder.encode(Pay(state: .approved)), encoding: .utf8)
        
        XCTAssertEqual(created, "{\"state\":\"created\"}")
        XCTAssertEqual(approved, "{\"state\":\"approved\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let failed = """
        {
            "state": "failed"
        }
        """.data(using: .utf8)!
        let created = """
        {
            "state": "created"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Pay.self, from: failed).state, .failed)
        try XCTAssertEqual(decoder.decode(Pay.self, from: created).state, .created)
    }
    
    static var allTests: [(String, (PaymentStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}







