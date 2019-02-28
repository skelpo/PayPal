import XCTest
@testable import PayPal

fileprivate typealias ID = FraudManagementFilter.ID

public final class FraudManagementFilterIDTests: XCTestCase {
    private struct Filter: Codable {
        let id: ID
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(ID.avsNoMatch.rawValue, "AVS_NO_MATCH")
        XCTAssertEqual(ID.avsPartialMatch.rawValue, "AVS_PARTIAL_MATCH")
        XCTAssertEqual(ID.avsUnavailable.rawValue, "AVS_UNAVAILABLE_OR_UNSUPPORTED")
        XCTAssertEqual(ID.securityCodeMismatch.rawValue, "CARD_SECURITY_CODE_MISMATCH")
        XCTAssertEqual(ID.maxAmount.rawValue, "MAXIMUM_TRANSACTION_AMOUNT")
        XCTAssertEqual(ID.unconfirmedAddress.rawValue, "UNCONFIRMED_ADDRESS")
        XCTAssertEqual(ID.countryMonitor.rawValue, "COUNTRY_MONITOR")
        XCTAssertEqual(ID.largeOrderNumber.rawValue, "LARGE_ORDER_NUMBER")
        XCTAssertEqual(ID.addressMismatch.rawValue, "BILLING_OR_SHIPPING_ADDRESS_MISMATCH")
        XCTAssertEqual(ID.riskyZip.rawValue, "RISKY_ZIP_CODE")
        XCTAssertEqual(ID.freightCheck.rawValue, "SUSPECTED_FREIGHT_FORWARDER_CHECK")
        XCTAssertEqual(ID.purchaseMin.rawValue, "TOTAL_PURCHASE_PRICE_MINIMUM")
        XCTAssertEqual(ID.ipVelocity.rawValue, "IP_ADDRESS_VELOCITY")
        XCTAssertEqual(ID.riskyDomainCheck.rawValue, "RISKY_EMAIL_ADDRESS_DOMAIN_CHECK")
        XCTAssertEqual(ID.riskyBankIDCheck.rawValue, "RISKY_BANK_IDENTIFICATION_NUMBER_CHECK")
        XCTAssertEqual(ID.riskyIPRange.rawValue, "RISKY_IP_ADDRESS_RANGE")
        XCTAssertEqual(ID.fraudModel.rawValue, "PAYPAL_FRAUD_MODEL")
    }
    
    func testAllCase() {
        XCTAssertEqual(ID.allCases.count, 17)
        XCTAssertEqual(ID.allCases, [
            .avsNoMatch, .avsPartialMatch, .avsUnavailable, .securityCodeMismatch, .maxAmount, .unconfirmedAddress, .countryMonitor, .largeOrderNumber,
            .addressMismatch, .riskyZip, .freightCheck, .purchaseMin, .ipVelocity, .riskyDomainCheck, .riskyBankIDCheck, .riskyIPRange, .fraudModel
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let avsNoMatch = try String(data: encoder.encode(Filter(id: .avsNoMatch)), encoding: .utf8)
        let avsPartialMatch = try String(data: encoder.encode(Filter(id: .avsPartialMatch)), encoding: .utf8)
        
        XCTAssertEqual(avsNoMatch, "{\"id\":\"AVS_NO_MATCH\"}")
        XCTAssertEqual(avsPartialMatch, "{\"id\":\"AVS_PARTIAL_MATCH\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let avsUnavailable = """
        {
            "id": "AVS_UNAVAILABLE_OR_UNSUPPORTED"
        }
        """.data(using: .utf8)!
        let securityCodeMismatch = """
        {
            "id": "CARD_SECURITY_CODE_MISMATCH"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Filter.self, from: avsUnavailable).id, .avsUnavailable)
        try XCTAssertEqual(decoder.decode(Filter.self, from: securityCodeMismatch).id, .securityCodeMismatch)
    }
    
    public static var allTests: [(String, (FraudManagementFilterIDTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






