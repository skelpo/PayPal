import XCTest
@testable import PayPal

public final class AcceptDisputeReasonTests: XCTestCase {
    struct Accept: Codable {
        let reason: AcceptDisputeBody.Reason
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(AcceptDisputeBody.Reason.notShipped.rawValue, "DID_NOT_SHIP_ITEM")
        XCTAssertEqual(AcceptDisputeBody.Reason.timeout.rawValue, "TOO_TIME_CONSUMING")
        XCTAssertEqual(AcceptDisputeBody.Reason.lost.rawValue, "LOST_IN_MAIL")
        XCTAssertEqual(AcceptDisputeBody.Reason.insufficentEvidance.rawValue, "NOT_ABLE_TO_WIN")
        XCTAssertEqual(AcceptDisputeBody.Reason.policy.rawValue, "COMPANY_POLICY")
        XCTAssertEqual(AcceptDisputeBody.Reason.none.rawValue, "REASON_NOT_SET")
    }
    
    func testAllCase() {
        XCTAssertEqual(AcceptDisputeBody.Reason.allCases.count, 6)
        XCTAssertEqual(AcceptDisputeBody.Reason.allCases, [.notShipped, .timeout, .lost, .insufficentEvidance, .policy, .none])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let notShipped = try String(data: encoder.encode(Accept(reason: .notShipped)), encoding: .utf8)
        let timeout = try String(data: encoder.encode(Accept(reason: .timeout)), encoding: .utf8)
        
        XCTAssertEqual(notShipped, "{\"reason\":\"DID_NOT_SHIP_ITEM\"}")
        XCTAssertEqual(timeout, "{\"reason\":\"TOO_TIME_CONSUMING\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let insufficentEvidance = """
        {
            "reason": "NOT_ABLE_TO_WIN"
        }
        """.data(using: .utf8)!
        let none = """
        {
            "reason": "REASON_NOT_SET"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Accept.self, from: insufficentEvidance).reason, .insufficentEvidance)
        try XCTAssertEqual(decoder.decode(Accept.self, from: none).reason, .none)
    }
    
    public static var allTests: [(String, (AcceptDisputeReasonTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


