import XCTest
@testable import PayPal

final class DisputeStatusTests: XCTestCase {
    struct Request: Codable {
        let method: PayPal.Method
    }
    
    struct Dispute: Codable {
        let status: CustomerDispute.Status
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(CustomerDispute.Status.open.rawValue, "OPEN")
        XCTAssertEqual(CustomerDispute.Status.waitingBuyer.rawValue, "WAITING_FOR_BUYER_RESPONSE")
        XCTAssertEqual(CustomerDispute.Status.waitingSeller.rawValue, "WAITING_FOR_SELLER_RESPONSE")
        XCTAssertEqual(CustomerDispute.Status.review.rawValue, "UNDER_REVIEW")
        XCTAssertEqual(CustomerDispute.Status.resolved.rawValue, "RESOLVED")
        XCTAssertEqual(CustomerDispute.Status.other.rawValue, "OTHER")
    }
    
    func testAllCase() {
        XCTAssertEqual(CustomerDispute.Status.allCases.count, 6)
        XCTAssertEqual(CustomerDispute.Status.allCases, [.open, .waitingBuyer, .waitingSeller, .review, .resolved, .other])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let waitingBuyer = try String(data: encoder.encode(Dispute(status: .waitingBuyer)), encoding: .utf8)
        let waitingSeller = try String(data: encoder.encode(Dispute(status: .waitingSeller)), encoding: .utf8)
        
        XCTAssertEqual(waitingBuyer, "{\"status\":\"WAITING_FOR_BUYER_RESPONSE\"}")
        XCTAssertEqual(waitingSeller, "{\"status\":\"WAITING_FOR_SELLER_RESPONSE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let review = """
        {
            "status": "UNDER_REVIEW"
        }
        """.data(using: .utf8)!
        let other = """
        {
            "status": "OTHER"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Dispute.self, from: review).status, .review)
        try XCTAssertEqual(decoder.decode(Dispute.self, from: other).status, .other)
    }
    
    static var allTests: [(String, (DisputeStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


