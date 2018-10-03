import XCTest
@testable import PayPal

final class DisputeOutcomeTests: XCTestCase {
    func testInit()throws {
        let outcome = try CustomerDispute.Outcome(code: .buyer, refunded: Money(currency: .usd, value: "56.72"))
        
        XCTAssertEqual(outcome.code, .buyer)
        try XCTAssertEqual(outcome.refunded, Money(currency: .usd, value: "56.72"))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let outcome = try CustomerDispute.Outcome(code: .buyer, refunded: Money(currency: .usd, value: "56.72"))
        let generated = try String(data: encoder.encode(outcome), encoding: .utf8)!
        
        XCTAssertEqual(generated, "{\"outcome_code\":\"RESOLVED_BUYER_FAVOUR\",\"amount_refunded\":{\"value\":\"56.72\",\"currency_code\":\"USD\"}}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let outcome = try CustomerDispute.Outcome(code: .buyer, refunded: Money(currency: .usd, value: "56.72"))
        let json = """
        {
            "outcome_code": "RESOLVED_BUYER_FAVOUR",
            "amount_refunded": {
                "value": "56.72",
                "currency_code": "USD"
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(outcome, decoder.decode(CustomerDispute.Outcome.self, from: json))
    }
    
    static var allTests: [(String, (DisputeOutcomeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


