import XCTest
@testable import PayPal

final class EvidenceTypeTests: XCTestCase {
    struct Evid: Codable {
        let type: Evidence.EvidenceType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Evidence.EvidenceType.proofOfFulfillment.rawValue, "PROOF_OF_FULFILLMENT")
        XCTAssertEqual(Evidence.EvidenceType.proofOfRefund.rawValue, "PROOF_OF_REFUND")
        XCTAssertEqual(Evidence.EvidenceType.proofOfDeliverySignature.rawValue, "PROOF_OF_DELIVERY_SIGNATURE")
        XCTAssertEqual(Evidence.EvidenceType.proofOfReceiptCopy.rawValue, "PROOF_OF_RECEIPT_COPY")
        XCTAssertEqual(Evidence.EvidenceType.returnPolicy.rawValue, "RETURN_POLICY")
        XCTAssertEqual(Evidence.EvidenceType.billingAgreement.rawValue, "BILLING_AGREEMENT")
        XCTAssertEqual(Evidence.EvidenceType.proofOfReshipment.rawValue, "PROOF_OF_RESHIPMENT")
        XCTAssertEqual(Evidence.EvidenceType.itemDescription.rawValue, "ITEM_DESCRIPTION")
        XCTAssertEqual(Evidence.EvidenceType.policeReport.rawValue, "POLICE_REPORT")
        XCTAssertEqual(Evidence.EvidenceType.affidavit.rawValue, "AFFIDAVIT")
        XCTAssertEqual(Evidence.EvidenceType.paidWithOtherMethod.rawValue, "PAID_WITH_OTHER_METHOD")
        XCTAssertEqual(Evidence.EvidenceType.copyOfContract.rawValue, "COPY_OF_CONTRACT")
        XCTAssertEqual(Evidence.EvidenceType.terminalAtmReceipt.rawValue, "TERMINAL_ATM_RECEIPT")
        XCTAssertEqual(Evidence.EvidenceType.priceDifferenceReason.rawValue, "PRICE_DIFFERENCE_REASON")
        XCTAssertEqual(Evidence.EvidenceType.sourceConversionRate.rawValue, "SOURCE_CONVERSION_RATE")
        XCTAssertEqual(Evidence.EvidenceType.bankStatement.rawValue, "BANK_STATEMENT")
        XCTAssertEqual(Evidence.EvidenceType.creditDueReason.rawValue, "CREDIT_DUE_REASON")
        XCTAssertEqual(Evidence.EvidenceType.requestCreditReceipt.rawValue, "REQUEST_CREDIT_RECEIPT")
        XCTAssertEqual(Evidence.EvidenceType.proofOfReturn.rawValue, "PROOF_OF_RETURN")
        XCTAssertEqual(Evidence.EvidenceType.create.rawValue, "CREATE")
        XCTAssertEqual(Evidence.EvidenceType.changeReason.rawValue, "CHANGE_REASON")
        XCTAssertEqual(Evidence.EvidenceType.other.rawValue, "OTHER")
    }
    
    func testAllCase() {
        XCTAssertEqual(Evidence.EvidenceType.allCases.count, 22)
        XCTAssertEqual(Evidence.EvidenceType.allCases, [
            .proofOfFulfillment, .proofOfRefund, .proofOfDeliverySignature, .proofOfReceiptCopy, .returnPolicy, .billingAgreement, .proofOfReshipment,
            .itemDescription, .policeReport, .affidavit, .paidWithOtherMethod, .copyOfContract, .terminalAtmReceipt, .priceDifferenceReason,
            .sourceConversionRate, .bankStatement, .creditDueReason, .requestCreditReceipt, .proofOfReturn, .create, .changeReason, .other
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let sourceConversionRate = try String(data: encoder.encode(Evid(type: .sourceConversionRate)), encoding: .utf8)
        let paidWithOtherMethod = try String(data: encoder.encode(Evid(type: .paidWithOtherMethod)), encoding: .utf8)
        
        XCTAssertEqual(sourceConversionRate, "{\"type\":\"SOURCE_CONVERSION_RATE\"}")
        XCTAssertEqual(paidWithOtherMethod, "{\"type\":\"PAID_WITH_OTHER_METHOD\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let requestCreditReceipt = """
        {
            "type": "REQUEST_CREDIT_RECEIPT"
        }
        """.data(using: .utf8)!
        let proofOfDeliverySignature = """
        {
            "type": "PROOF_OF_DELIVERY_SIGNATURE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Evid.self, from: requestCreditReceipt).type, .requestCreditReceipt)
        try XCTAssertEqual(decoder.decode(Evid.self, from: proofOfDeliverySignature).type, .proofOfDeliverySignature)
    }
    
    static var allTests: [(String, (EvidenceTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


