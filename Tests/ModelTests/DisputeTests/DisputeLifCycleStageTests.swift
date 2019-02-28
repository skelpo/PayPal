import XCTest
@testable import PayPal

public final class DisputeLifeCycleTests: XCTestCase {
    struct Dispute: Codable {
        let stage: CustomerDispute.LifeCycleStage
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(CustomerDispute.LifeCycleStage.inquiry.rawValue, "INQUIRY")
        XCTAssertEqual(CustomerDispute.LifeCycleStage.chargeback.rawValue, "CHARGEBACK")
        XCTAssertEqual(CustomerDispute.LifeCycleStage.preArbiration.rawValue, "PRE_ARBITRATION")
        XCTAssertEqual(CustomerDispute.LifeCycleStage.arbitration.rawValue, "ARBITRATION")
    }
    
    func testAllCase() {
        XCTAssertEqual(CustomerDispute.LifeCycleStage.allCases.count, 4)
        XCTAssertEqual(CustomerDispute.LifeCycleStage.allCases, [.inquiry, .chargeback, .preArbiration, .arbitration])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let inquiry = try String(data: encoder.encode(Dispute(stage: .inquiry)), encoding: .utf8)
        let chargeback = try String(data: encoder.encode(Dispute(stage: .chargeback)), encoding: .utf8)
        
        XCTAssertEqual(inquiry, "{\"stage\":\"INQUIRY\"}")
        XCTAssertEqual(chargeback, "{\"stage\":\"CHARGEBACK\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let preArbiration = """
        {
            "stage": "PRE_ARBITRATION"
        }
        """.data(using: .utf8)!
        let arbitration = """
        {
            "stage": "ARBITRATION"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Dispute.self, from: preArbiration).stage, .preArbiration)
        try XCTAssertEqual(decoder.decode(Dispute.self, from: arbitration).stage, .arbitration)
    }
    
    public static var allTests: [(String, (DisputeLifeCycleTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



