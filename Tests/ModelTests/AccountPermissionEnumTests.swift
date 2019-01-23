import XCTest
@testable import PayPal

private typealias Permission = AccountPermission.Permission

final class AccountPermissionEnumTests: XCTestCase {
    private struct Account: Codable {
        let permission: Permission
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Permission.directPayment.rawValue, "DIRECT_PAYMENT")
        XCTAssertEqual(Permission.expressCheckout.rawValue, "EXPRESS_CHECKOUT")
        XCTAssertEqual(Permission.recurringPayment.rawValue, "RECURRING_PAYMENT")
        XCTAssertEqual(Permission.extendedProProcessing.rawValue, "EXTENDED_PRO_PROCESSING")
        XCTAssertEqual(Permission.exceptionProcessing.rawValue, "EXCEPTION_PROCESSING")
        XCTAssertEqual(Permission.settlementConsolidation.rawValue, "SETTLEMENT_CONSOLIDATION")
        XCTAssertEqual(Permission.settlementReporting.rawValue, "SETTLEMENT_REPORTING")
        XCTAssertEqual(Permission.massPay.rawValue, "MASS_PAY")
        XCTAssertEqual(Permission.encryptedWebsitePayments.rawValue, "ENCRYPTED_WEBSITE_PAYMENTS")
        XCTAssertEqual(Permission.disputeResolution.rawValue, "DISPUTE_RESOLUTION")
        XCTAssertEqual(Permission.sharedRefund.rawValue, "SHARED_REFUND")
        XCTAssertEqual(Permission.sharedAuthorization.rawValue, "SHARED_AUTHORIZATION")
        XCTAssertEqual(Permission.viewBalance.rawValue, "VIEW_BALANCE")
        XCTAssertEqual(Permission.viewProfile.rawValue, "VIEW_PROFILE")
        XCTAssertEqual(Permission.editProfile.rawValue, "EDIT_PROFILE")
    }
    
    func testAllCase() {
        XCTAssertEqual(Permission.allCases.count, 15)
        XCTAssertEqual(Permission.allCases, [
            .directPayment, .expressCheckout, .recurringPayment, .extendedProProcessing, .exceptionProcessing, .settlementConsolidation, .settlementReporting,
            .massPay, .encryptedWebsitePayments, .disputeResolution, .sharedRefund, .sharedAuthorization, .viewBalance, .viewProfile, .editProfile
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let directPayment = try String(data: encoder.encode(Account(permission: .directPayment)), encoding: .utf8)
        let expressCheckout = try String(data: encoder.encode(Account(permission: .expressCheckout)), encoding: .utf8)
        
        XCTAssertEqual(directPayment, "{\"permission\":\"DIRECT_PAYMENT\"}")
        XCTAssertEqual(expressCheckout, "{\"permission\":\"EXPRESS_CHECKOUT\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let recurringPayment = """
        {
            "permission": "RECURRING_PAYMENT"
        }
        """.data(using: .utf8)!
        let extendedProProcessing = """
        {
            "permission": "EXTENDED_PRO_PROCESSING"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Account.self, from: recurringPayment).permission, .recurringPayment)
        try XCTAssertEqual(decoder.decode(Account.self, from: extendedProProcessing).permission, .extendedProProcessing)
    }
    
    static var allTests: [(String, (AccountPermissionEnumTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

