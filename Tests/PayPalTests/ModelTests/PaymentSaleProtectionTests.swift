import XCTest
@testable import PayPal

fileprivate typealias Protection = RelatedResource.Sale.Protection

final class PaymentSaleProtectionTests: XCTestCase {
    private struct Sale: Codable {
        let protection: Protection
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Protection.eligible.rawValue, "ELIGIBLE")
        XCTAssertEqual(Protection.partiallyEligible.rawValue, "PARTIALLY_ELIGIBLE")
        XCTAssertEqual(Protection.ineligible.rawValue, "INELIGIBLE")
    }
    
    func testAllCase() {
        XCTAssertEqual(Protection.allCases.count, 3)
        XCTAssertEqual(Protection.allCases, [.eligible, .partiallyEligible, .ineligible])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let eligible = try String(data: encoder.encode(Sale(protection: .eligible)), encoding: .utf8)
        let partiallyEligible = try String(data: encoder.encode(Sale(protection: .partiallyEligible)), encoding: .utf8)
        
        XCTAssertEqual(eligible, "{\"protection\":\"ELIGIBLE\"}")
        XCTAssertEqual(partiallyEligible, "{\"protection\":\"PARTIALLY_ELIGIBLE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let ineligible = """
        {
            "protection": "DELAYED_TRANSFER"
        }
        """.data(using: .utf8)!
        let eligible = """
        {
            "protection": "ELIGIBLE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Sale.self, from: ineligible).protection, .ineligible)
        try XCTAssertEqual(decoder.decode(Sale.self, from: eligible).protection, .eligible)
    }
    
    static var allTests: [(String, (PaymentSaleProtectionTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
