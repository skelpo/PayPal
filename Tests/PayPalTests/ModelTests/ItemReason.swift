import XCTest
@testable import PayPal

final class ItemReasonTests: XCTestCase {
    struct Request: Codable {
        let method: PayPal.Method
    }
    
    struct IT: Codable {
        let reason: Item.Reason
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Item.Reason.notReceived.rawValue, "MERCHANDISE_OR_SERVICE_NOT_RECEIVED")
        XCTAssertEqual(Item.Reason.notAsDescribed.rawValue, "MERCHANDISE_OR_SERVICE_NOT_AS_DESCRIBED")
        XCTAssertEqual(Item.Reason.unauthorized.rawValue, "UNAUTHORISED")
        XCTAssertEqual(Item.Reason.notProcessed.rawValue, "CREDIT_NOT_PROCESSED")
        XCTAssertEqual(Item.Reason.duplicate.rawValue, "DUPLICATE_TRANSACTION")
        XCTAssertEqual(Item.Reason.incorrectAmount.rawValue, "INCORRECT_AMOUNT")
        XCTAssertEqual(Item.Reason.paymentByOtherMeans.rawValue, "PAYMENT_BY_OTHER_MEANS")
        XCTAssertEqual(Item.Reason.reacurringCancelled.rawValue, "CANCELED_RECURRING_BILLING")
        XCTAssertEqual(Item.Reason.remittanceIssue.rawValue, "PROBLEM_WITH_REMITTANCE")
        XCTAssertEqual(Item.Reason.other.rawValue, "OTHER")
    }
    
    func testAllCase() {
        XCTAssertEqual(Item.Reason.allCases.count, 10)
        XCTAssertEqual(Item.Reason.allCases, [
            .notReceived, .notAsDescribed, .unauthorized, .notProcessed, .duplicate, .incorrectAmount,
            .paymentByOtherMeans, .reacurringCancelled, .remittanceIssue, .other
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let notReceived = try String(data: encoder.encode(IT(reason: .notReceived)), encoding: .utf8)
        let notAsDescribed = try String(data: encoder.encode(IT(reason: .notAsDescribed)), encoding: .utf8)
        
        XCTAssertEqual(notReceived, "{\"reason\":\"MERCHANDISE_OR_SERVICE_NOT_RECEIVED\"}")
        XCTAssertEqual(notAsDescribed, "{\"reason\":\"MERCHANDISE_OR_SERVICE_NOT_AS_DESCRIBED\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let paymentByOtherMeans = """
        {
            "reason": "PAYMENT_BY_OTHER_MEANS"
        }
        """.data(using: .utf8)!
        let reacurringCancelled = """
        {
            "reason": "CANCELED_RECURRING_BILLING"
        }
        """
        
        try XCTAssertEqual(decoder.decode(IT.self, from: paymentByOtherMeans).reason, .paymentByOtherMeans)
        try XCTAssertEqual(decoder.decode(IT.self, from: reacurringCancelled).reason, .reacurringCancelled)
    }
    
    static var allTests: [(String, (ItemReasonTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


