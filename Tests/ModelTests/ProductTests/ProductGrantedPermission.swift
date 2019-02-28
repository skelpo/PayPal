import XCTest
@testable import PayPal

private typealias Permission = Product.GrantedPermission

public final class ProductGrantedPermissionTests: XCTestCase {
    private struct Product: Codable {
        let permission: Permission
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Permission.expressCheckout.rawValue, "EXPRESS_CHECKOUT")
        XCTAssertEqual(Permission.refund.rawValue, "REFUND")
        XCTAssertEqual(Permission.directPayment.rawValue, "DIRECT_PAYMENT")
        XCTAssertEqual(Permission.authCapture.rawValue, "AUTH_CAPTURE")
        XCTAssertEqual(Permission.buttonManager.rawValue, "BUTTON_MANAGER")
        XCTAssertEqual(Permission.accountBalance.rawValue, "ACCOUNT_BALANCE")
        XCTAssertEqual(Permission.transactionDetails.rawValue, "TRANSACTION_DETAILS")
        XCTAssertEqual(Permission.transactionSearch.rawValue, "TRANSACTION_SEARCH")
        XCTAssertEqual(Permission.referenceTransaction.rawValue, "REFERENCE_TRANSACTION")
        XCTAssertEqual(Permission.recurringPayments.rawValue, "RECURRING_PAYMENTS")
        XCTAssertEqual(Permission.billingAgreement.rawValue, "BILLING_AGREEMENT")
        XCTAssertEqual(Permission.managePendingTransactionStatus.rawValue, "MANAGE_PENDING_TRANSACTION_STATUS")
        XCTAssertEqual(Permission.nonReferencedCredit.rawValue, "NON_REFERENCED_CREDIT")
        XCTAssertEqual(Permission.massPay.rawValue, "MASS_PAY")
        XCTAssertEqual(Permission.encryptedWebsitePayments.rawValue, "ENCRYPTED_WEBSITE_PAYMENTS")
        XCTAssertEqual(Permission.settlementConsolidation.rawValue, "SETTLEMENT_CONSOLIDATION")
        XCTAssertEqual(Permission.settlementReporting.rawValue, "SETTLEMENT_REPORTING")
        XCTAssertEqual(Permission.mobileCheckout.rawValue, "MOBILE_CHECKOUT")
        XCTAssertEqual(Permission.airTravel.rawValue, "AIR_TRAVEL")
        XCTAssertEqual(Permission.invoicing.rawValue, "INVOICING")
        XCTAssertEqual(Permission.recurringPaymentReport.rawValue, "RECURRING_PAYMENT_REPORT")
        XCTAssertEqual(Permission.extendedProProcessingReport.rawValue, "EXTENDED_PRO_PROCESSING_REPORT")
        XCTAssertEqual(Permission.exceptionProcessingReport.rawValue, "EXCEPTION_PROCESSING_REPORT")
        XCTAssertEqual(Permission.transactionDetailReport.rawValue, "TRANSACTION_DETAIL_REPORT")
        XCTAssertEqual(Permission.accountManagementPermission.rawValue, "ACCOUNT_MANAGEMENT_PERMISSION")
        XCTAssertEqual(Permission.accessBasicPersonalData.rawValue, "ACCESS_BASIC_PERSONAL_DATA")
        XCTAssertEqual(Permission.accessAdvancedPersonalData.rawValue, "ACCESS_ADVANCED_PERSONAL_DATA")
    }
    
    func testAllCase() {
        XCTAssertEqual(Permission.allCases.count, 27)
        XCTAssertEqual(Permission.allCases, [
            .expressCheckout, .refund, .directPayment, .authCapture, .buttonManager, .accountBalance, .transactionDetails, .transactionSearch,
            .referenceTransaction, .recurringPayments, .billingAgreement, .managePendingTransactionStatus, .nonReferencedCredit, .massPay,
            .encryptedWebsitePayments, .settlementConsolidation, .settlementReporting, .mobileCheckout, .airTravel, .invoicing,
            .recurringPaymentReport, .extendedProProcessingReport, .exceptionProcessingReport, .transactionDetailReport,
            .accountManagementPermission, .accessBasicPersonalData, .accessAdvancedPersonalData
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let nonReferencedCredit = try String(data: encoder.encode(Product(permission: .nonReferencedCredit)), encoding: .utf8)
        let managePendingTransactionStatus = try String(data: encoder.encode(Product(permission: .managePendingTransactionStatus)), encoding: .utf8)
        
        XCTAssertEqual(nonReferencedCredit, "{\"permission\":\"NON_REFERENCED_CREDIT\"}")
        XCTAssertEqual(managePendingTransactionStatus, "{\"permission\":\"MANAGE_PENDING_TRANSACTION_STATUS\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let accessAdvancedPersonalData = """
        {
            "permission": "ACCESS_ADVANCED_PERSONAL_DATA"
        }
        """.data(using: .utf8)!
        let accountManagementPermission = """
        {
            "permission": "ACCOUNT_MANAGEMENT_PERMISSION"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Product.self, from: accessAdvancedPersonalData).permission, .accessAdvancedPersonalData)
        try XCTAssertEqual(decoder.decode(Product.self, from: accountManagementPermission).permission, .accountManagementPermission)
    }
    
    public static var allTests: [(String, (ProductGrantedPermissionTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





