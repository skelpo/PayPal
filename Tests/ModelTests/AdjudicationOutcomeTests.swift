import XCTest
@testable import PayPal

final class AdjudicationOutcomeTests: XCTestCase {
    struct Adjudication: Codable {
        let outcome: AdjudicationOutcome
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(AdjudicationOutcome.buyer.rawValue, "BUYER_FAVOR")
        XCTAssertEqual(AdjudicationOutcome.seller.rawValue, "SELLER_FAVOR")
    }
    
    func testAllCase() {
        XCTAssertEqual(AdjudicationOutcome.allCases.count, 2)
        XCTAssertEqual(AdjudicationOutcome.allCases, [.buyer, .seller])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let buyer = try String(data: encoder.encode(Adjudication(outcome: .buyer)), encoding: .utf8)
        let seller = try String(data: encoder.encode(Adjudication(outcome: .seller)), encoding: .utf8)
        
        XCTAssertEqual(buyer, "{\"outcome\":\"BUYER_FAVOR\"}")
        XCTAssertEqual(seller, "{\"outcome\":\"SELLER_FAVOR\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let buyer = """
        {
            "outcome": "BUYER_FAVOR"
        }
        """.data(using: .utf8)!
        let seller = """
        {
            "outcome": "SELLER_FAVOR"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Adjudication.self, from: buyer).outcome, .buyer)
        try XCTAssertEqual(decoder.decode(Adjudication.self, from: seller).outcome, .seller)
    }
    
    static var allTests: [(String, (AdjudicationOutcomeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





