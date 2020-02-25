import XCTest
@testable import PayPal

private typealias Name = Product.Name

public final class ProductNameTests: XCTestCase {
    private struct Product: Codable {
        let name: Name
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Name.expressCheckout.rawValue, "EXPRESS_CHECKOUT")
        XCTAssertEqual(Name.websitePaymentsStandard.rawValue, "WEBSITE_PAYMENTS_STANDARD")
        XCTAssertEqual(Name.massPayment.rawValue, "MASS_PAYMENT")
        XCTAssertEqual(Name.emailPayments.rawValue, "EMAIL_PAYMENTS")
        XCTAssertEqual(Name.ebayCheckout.rawValue, "EBAY_CHECKOUT")
        XCTAssertEqual(Name.payflowLink.rawValue, "PAYFLOW_LINK")
        XCTAssertEqual(Name.payflowPro.rawValue, "PAYFLOW_PRO")
        XCTAssertEqual(Name.websitePaymentsPro30.rawValue, "WEBSITE_PAYMENTS_PRO_3_0")
        XCTAssertEqual(Name.websitePaymentsPro20.rawValue, "WEBSITE_PAYMENTS_PRO_2_0")
        XCTAssertEqual(Name.virtualTreminal.rawValue, "VIRTUAL_TERMINAL")
        XCTAssertEqual(Name.hostedSoleSolution.rawValue, "HOSTED_SOLE_SOLUTION")
        XCTAssertEqual(Name.billMeLater.rawValue, "BILL_ME_LATER")
        XCTAssertEqual(Name.mobileExpressCheckout.rawValue, "MOBILE_EXPRESS_CHECKOUT")
        XCTAssertEqual(Name.paypalHere.rawValue, "PAYPAL_HERE")
        XCTAssertEqual(Name.mobileInStore.rawValue, "MOBILE_IN_STORE")
        XCTAssertEqual(Name.paypalStandard.rawValue, "PAYPAL_STANDARD")
        XCTAssertEqual(Name.mobilePaypalStandard.rawValue, "MOBILE_PAYPAL_STANDARD")
        XCTAssertEqual(Name.mobilePaymentAcceptance.rawValue, "MOBILE_PAYMENT_ACCEPTANCE")
        XCTAssertEqual(Name.paypalAdvanced.rawValue, "PAYPAL_ADVANCED")
        XCTAssertEqual(Name.paypalPro.rawValue, "PAYPAL_PRO")
        XCTAssertEqual(Name.enhancedRecurringPayments.rawValue, "ENHANCED_RECURRING_PAYMENTS")
    }
    
    func testAllCase() {
        XCTAssertEqual(Name.allCases.count, 21)
        XCTAssertEqual(Name.allCases, [
            .expressCheckout, .websitePaymentsStandard, .massPayment, .emailPayments, .ebayCheckout, .payflowLink, .payflowPro,
            .websitePaymentsPro30, .websitePaymentsPro20, .virtualTreminal, .hostedSoleSolution, .billMeLater, .mobileExpressCheckout, .paypalHere,
            .mobileInStore, .paypalStandard, .mobilePaypalStandard, .mobilePaymentAcceptance, .paypalAdvanced, .paypalPro, .enhancedRecurringPayments
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let enhancedRecurringPayments = try String(data: encoder.encode(Product(name: .enhancedRecurringPayments)), encoding: .utf8)
        let paypalPro = try String(data: encoder.encode(Product(name: .paypalPro)), encoding: .utf8)
        
        XCTAssertEqual(enhancedRecurringPayments, "{\"name\":\"ENHANCED_RECURRING_PAYMENTS\"}")
        XCTAssertEqual(paypalPro, "{\"name\":\"PAYPAL_PRO\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let mobileExpressCheckout = """
        {
            "name": "MOBILE_EXPRESS_CHECKOUT"
        }
        """.data(using: .utf8)!
        let hostedSoleSolution = """
        {
            "name": "HOSTED_SOLE_SOLUTION"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Product.self, from: mobileExpressCheckout).name, .mobileExpressCheckout)
        try XCTAssertEqual(decoder.decode(Product.self, from: hostedSoleSolution).name, .hostedSoleSolution)
    }
    
    public static var allTests: [(String, (ProductNameTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




