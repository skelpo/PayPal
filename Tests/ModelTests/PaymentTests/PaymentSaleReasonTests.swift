import XCTest
@testable import PayPal

fileprivate typealias Reason = RelatedResource.Sale.Reason

public final class PaymentSaleReasonTests: XCTestCase {
    private struct Sale: Codable {
        let reason: Reason
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Reason.chargeback.rawValue, "CHARGEBACK")
        XCTAssertEqual(Reason.guarantee.rawValue, "GUARANTEE")
        XCTAssertEqual(Reason.complaint.rawValue, "BUYER_COMPLAINT")
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
            .chargeback, .guarantee, .complaint, .refund, .unconfirmedAddress, .echeck, .withdrawl, .manualAction, .payment, .regulatory, .unilateral, .verification, .awaitingFunding
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let chargeback = try String(data: encoder.encode(Sale(reason: .chargeback)), encoding: .utf8)
        let guarantee = try String(data: encoder.encode(Sale(reason: .guarantee)), encoding: .utf8)
        
        XCTAssertEqual(chargeback, "{\"reason\":\"CHARGEBACK\"}")
        XCTAssertEqual(guarantee, "{\"reason\":\"GUARANTEE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let complaint = """
        {
            "reason": "BUYER_COMPLAINT"
        }
        """.data(using: .utf8)!
        let refund = """
        {
            "reason": "REFUND"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Sale.self, from: complaint).reason, .complaint)
        try XCTAssertEqual(decoder.decode(Sale.self, from: refund).reason, .refund)
    }
    
    public static var allTests: [(String, (PaymentSaleReasonTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}









