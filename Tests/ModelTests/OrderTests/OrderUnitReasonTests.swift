import XCTest
@testable import PayPal

typealias UnitReason = Order.Unit.Reason

final class OrderUnitReasonTests: XCTestCase {
    struct Unit: Codable {
        let reason: UnitReason
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(UnitReason.unconfirmedAddress.rawValue, "PAYER_SHIPPING_UNCONFIRMED")
        XCTAssertEqual(UnitReason.multiCurrency.rawValue, "MULTI_CURRENCY")
        XCTAssertEqual(UnitReason.risk.rawValue, "RISK_REVIEW")
        XCTAssertEqual(UnitReason.regulatory.rawValue, "REGULATORY_REVIEW")
        XCTAssertEqual(UnitReason.verification.rawValue, "VERIFICATION_REQUIRED")
        XCTAssertEqual(UnitReason.order.rawValue, "ORDER")
        XCTAssertEqual(UnitReason.other.rawValue, "OTHER")
        XCTAssertEqual(UnitReason.declinedByPolicy.rawValue, "DECLINED_BY_POLICY")
    }
    
    func testAllCase() {
        XCTAssertEqual(UnitReason.allCases.count, 8)
        XCTAssertEqual(UnitReason.allCases, [.unconfirmedAddress, .multiCurrency, .risk, .regulatory, .verification, .order, .other, .declinedByPolicy])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let unconfirmedAddress = try String(data: encoder.encode(Unit(reason: .unconfirmedAddress)), encoding: .utf8)
        let multiCurrency = try String(data: encoder.encode(Unit(reason: .multiCurrency)), encoding: .utf8)
        
        XCTAssertEqual(unconfirmedAddress, "{\"reason\":\"PAYER_SHIPPING_UNCONFIRMED\"}")
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
        
        try XCTAssertEqual(decoder.decode(Unit.self, from: risk).reason, .risk)
        try XCTAssertEqual(decoder.decode(Unit.self, from: regulatory).reason, .regulatory)
    }
    
    static var allTests: [(String, (OrderUnitReasonTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}








