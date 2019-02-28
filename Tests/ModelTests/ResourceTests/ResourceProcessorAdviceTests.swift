import XCTest
@testable import PayPal

fileprivate typealias Advice = RelatedResource.ProcessorResponse.AdviceCode

public final class ResourceProcessorAdviceTests: XCTestCase {
    private struct Processor: Codable {
        let advice: Advice
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Advice.newAccount.rawValue, "01_NEW_ACCOUNT_INFORMATION")
        XCTAssertEqual(Advice.tryAgain.rawValue, "02_TRY_AGAIN_LATER")
        XCTAssertEqual(Advice.stopSpecific.rawValue, "02_STOP_SPECIFIC_PAYMENT")
        XCTAssertEqual(Advice.dontTry.rawValue, "03_DO_NOT_TRY_AGAIN")
        XCTAssertEqual(Advice.revokeAuthorization.rawValue, "03_REVOKE_AUTHORIZATION_FOR_FUTURE_PAYMENT")
        XCTAssertEqual(Advice.canceledRecurring.rawValue, "21_DO_NOT_TRY_AGAIN_CARD_HOLDER_CANCELLED_RECURRRING_CHARGE")
        XCTAssertEqual(Advice.canceledAllRecurring.rawValue, "21_CANCEL_ALL_RECURRING_PAYMENTS")
    }
    
    func testAllCase() {
        XCTAssertEqual(Advice.allCases.count, 7)
        XCTAssertEqual(Advice.allCases, [
            .newAccount, .tryAgain, .stopSpecific, .dontTry, .revokeAuthorization, .canceledRecurring, .canceledAllRecurring
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let newAccount = try String(data: encoder.encode(Processor(advice: .newAccount)), encoding: .utf8)
        let tryAgain = try String(data: encoder.encode(Processor(advice: .tryAgain)), encoding: .utf8)
        
        XCTAssertEqual(newAccount, "{\"advice\":\"01_NEW_ACCOUNT_INFORMATION\"}")
        XCTAssertEqual(tryAgain, "{\"advice\":\"02_TRY_AGAIN_LATER\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let stopSpecific = """
        {
            "advice": "02_STOP_SPECIFIC_PAYMENT"
        }
        """.data(using: .utf8)!
        let dontTry = """
        {
            "advice": "03_DO_NOT_TRY_AGAIN"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Processor.self, from: stopSpecific).advice, .stopSpecific)
        try XCTAssertEqual(decoder.decode(Processor.self, from: dontTry).advice, .dontTry)
    }
    
    public static var allTests: [(String, (ResourceProcessorAdviceTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}








