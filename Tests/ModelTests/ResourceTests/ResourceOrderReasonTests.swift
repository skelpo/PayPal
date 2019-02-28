import XCTest
@testable import PayPal

fileprivate typealias Reason = RelatedResource.Order.Reason

public final class ResourceOrderReasonTests: XCTestCase {
    private struct Order: Codable {
        let reason: Reason
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Reason.shippingUnconfirmed.rawValue, "PAYER_SHIPPING_UNCONFIRMED")
        XCTAssertEqual(Reason.multiCurrency.rawValue, "MULTI_CURRENCY")
        XCTAssertEqual(Reason.risk.rawValue, "RISK_REVIEW")
        XCTAssertEqual(Reason.regulatory.rawValue, "REGULATORY_REVIEW")
        XCTAssertEqual(Reason.verification.rawValue, "VERIFICATION_REQUIRED")
        XCTAssertEqual(Reason.order.rawValue, "ORDER")
        XCTAssertEqual(Reason.other.rawValue, "OTHER")
    }
    
    func testAllCase() {
        XCTAssertEqual(Reason.allCases.count, 7)
        XCTAssertEqual(Reason.allCases, [.shippingUnconfirmed, .multiCurrency, .risk, .regulatory, .verification, .order, .other])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let shippingUnconfirmed = try String(data: encoder.encode(Order(reason: .shippingUnconfirmed)), encoding: .utf8)
        let multiCurrency = try String(data: encoder.encode(Order(reason: .multiCurrency)), encoding: .utf8)
        
        XCTAssertEqual(shippingUnconfirmed, "{\"reason\":\"PAYER_SHIPPING_UNCONFIRMED\"}")
        XCTAssertEqual(multiCurrency, "{\"reason\":\"MULTI_CURRENCY\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let risk = """
        {
            "reason": "RISK_REVIEW"
        }
        """.data(using: .utf8)!
        let regulatory = """
        {
            "reason": "REGULATORY_REVIEW"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Order.self, from: risk).reason, .risk)
        try XCTAssertEqual(decoder.decode(Order.self, from: regulatory).reason, .regulatory)
    }
    
    public static var allTests: [(String, (ResourceOrderReasonTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}










