import XCTest
@testable import PayPal

typealias CapReas = Capture.Reason

public final class CaptureReasonTests: XCTestCase {
    struct Cap: Codable {
        let reason: CapReas
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(CapReas.chargeback.rawValue, "CHARGEBACK")
        XCTAssertEqual(CapReas.guarantee.rawValue, "GUARANTEE")
        XCTAssertEqual(CapReas.buyerComplaint.rawValue, "BUYER_COMPLAINT")
        XCTAssertEqual(CapReas.refund.rawValue, "REFUND")
        XCTAssertEqual(CapReas.unconfirmedAddress.rawValue, "UNCONFIRMED_SHIPPING_ADDRESS")
        XCTAssertEqual(CapReas.echeck.rawValue, "ECHECK")
        XCTAssertEqual(CapReas.internationalWithdrawal.rawValue, "INTERNATIONAL_WITHDRAWAL")
        XCTAssertEqual(CapReas.manualAction.rawValue, "RECEIVING_PREFERENCE_MANDATES_MANUAL_ACTION")
        XCTAssertEqual(CapReas.review.rawValue, "PAYMENT_REVIEW")
        XCTAssertEqual(CapReas.regulatory.rawValue, "REGULATORY_REVIEW")
        XCTAssertEqual(CapReas.unilateral.rawValue, "UNILATERAL")
        XCTAssertEqual(CapReas.verification.rawValue, "VERIFICATION_REQUIRED")
        XCTAssertEqual(CapReas.disbursement.rawValue, "DELAYED_DISBURSEMENT")
    }
    
    func testAllCase() {
        XCTAssertEqual(CapReas.allCases.count, 13)
        XCTAssertEqual(CapReas.allCases, [
            .chargeback, .guarantee, .buyerComplaint, .refund, .unconfirmedAddress, .echeck, .internationalWithdrawal, .manualAction, .review, .regulatory,
            .unilateral, .verification, .disbursement
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let chargeback = try String(data: encoder.encode(Cap(reason: .chargeback)), encoding: .utf8)
        let guarantee = try String(data: encoder.encode(Cap(reason: .guarantee)), encoding: .utf8)
        
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
        let unconfirmedAddress = """
        {
            "reason": "UNCONFIRMED_SHIPPING_ADDRESS"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Cap.self, from: buyerComplaint).reason, .buyerComplaint)
        try XCTAssertEqual(decoder.decode(Cap.self, from: unconfirmedAddress).reason, .unconfirmedAddress)
    }
    
    static var allTests: [(String, (CaptureReasonTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





