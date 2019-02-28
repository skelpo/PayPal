import XCTest
@testable import PayPal

fileprivate typealias Reason = RelatedResource.Capture.Reason

final class ResourceCaptureReasonTests: XCTestCase {
    private struct Capture: Codable {
        let reason: Reason
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Reason.chargeback.rawValue, "CHARGEBACK")
        XCTAssertEqual(Reason.guarantee.rawValue, "GUARANTEE")
        XCTAssertEqual(Reason.buyerComplaint.rawValue, "BUYER_COMPLAINT")
        XCTAssertEqual(Reason.refund.rawValue, "REFUND")
        XCTAssertEqual(Reason.unconfirmedAddress.rawValue, "UNCONFIRMED_SHIPPING_ADDRESS")
        XCTAssertEqual(Reason.echeck.rawValue, "ECHECK")
        XCTAssertEqual(Reason.withdrawl.rawValue, "INTERNATIONAL_WITHDRAWAL")
        XCTAssertEqual(Reason.manualAction.rawValue, "RECEIVING_PREFERENCE_MANDATES_MANUAL_ACTION")
        XCTAssertEqual(Reason.payment.rawValue, "PAYMENT_REVIEW")
        XCTAssertEqual(Reason.regulatory.rawValue, "REGULATORY_REVIEW")
        XCTAssertEqual(Reason.unilateral.rawValue, "UNILATERAL")
        XCTAssertEqual(Reason.verification.rawValue, "VERIFICATION_REQUIRED")
        XCTAssertEqual(Reason.awaitingFunding.rawValue, "TRANSACTION_APPROVED_AWAITING_FUNDING")
    }
    
    func testAllCase() {
        XCTAssertEqual(Reason.allCases.count, 13)
        XCTAssertEqual(Reason.allCases, [
            .chargeback, .guarantee, .buyerComplaint, .refund, .unconfirmedAddress, .echeck, .withdrawl, .manualAction, .payment,
            .regulatory, .unilateral, .verification, .awaitingFunding
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let chargeback = try String(data: encoder.encode(Capture(reason: .chargeback)), encoding: .utf8)
        let guarantee = try String(data: encoder.encode(Capture(reason: .guarantee)), encoding: .utf8)
        
        XCTAssertEqual(chargeback, "{\"reason\":\"CHARGEBACK\"}")
        XCTAssertEqual(guarantee, "{\"reason\":\"GUARANTEE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let buyerComplaint = """
        {
            "reason": "BUYER_COMPLAINT"
        }
        """.data(using: .utf8)!
        let refund = """
        {
            "reason": "REFUND"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Capture.self, from: buyerComplaint).reason, .buyerComplaint)
        try XCTAssertEqual(decoder.decode(Capture.self, from: refund).reason, .refund)
    }
    
    static var allTests: [(String, (ResourceCaptureReasonTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}












