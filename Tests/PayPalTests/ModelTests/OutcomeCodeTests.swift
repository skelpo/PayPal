import XCTest
@testable import PayPal

final class OutcomeCodeTests: XCTestCase {
    struct Out: Codable {
        let code: CustomerDispute.Outcome.Code
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(CustomerDispute.Outcome.Code.buyer.rawValue, "RESOLVED_BUYER_FAVOUR")
        XCTAssertEqual(CustomerDispute.Outcome.Code.seller.rawValue, "RESOLVED_SELLER_FAVOUR")
        XCTAssertEqual(CustomerDispute.Outcome.Code.resolved.rawValue, "RESOLVED_WITH_PAYOUT")
        XCTAssertEqual(CustomerDispute.Outcome.Code.cancelled.rawValue, "CANCELED_BY_BUYER")
        XCTAssertEqual(CustomerDispute.Outcome.Code.accepted.rawValue, "ACCEPTED")
        XCTAssertEqual(CustomerDispute.Outcome.Code.denied.rawValue, "DENIED")
    }
    
    func testAllCase() {
        XCTAssertEqual(CustomerDispute.Outcome.Code.allCases.count, 6)
        XCTAssertEqual(CustomerDispute.Outcome.Code.allCases, [.buyer, .seller, .resolved, .cancelled, .accepted, .denied])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let buyer = try String(data: encoder.encode(Out(code: .buyer)), encoding: .utf8)
        let seller = try String(data: encoder.encode(Out(code: .seller)), encoding: .utf8)
        
        XCTAssertEqual(buyer, "{\"code\":\"RESOLVED_BUYER_FAVOUR\"}")
        XCTAssertEqual(seller, "{\"code\":\"RESOLVED_SELLER_FAVOUR\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let resolved = """
        {
            "code": "RESOLVED_WITH_PAYOUT"
        }
        """.data(using: .utf8)!
        let cancelled = """
        {
            "code": "CANCELED_BY_BUYER"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Out.self, from: resolved).code, .resolved)
        try XCTAssertEqual(decoder.decode(Out.self, from: cancelled).code, .cancelled)
    }
    
    static var allTests: [(String, (OutcomeCodeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


