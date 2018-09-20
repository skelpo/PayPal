import XCTest
@testable import PayPal

fileprivate typealias Method = Order.Payer.Method

final class OrderPaymentMethodTests: XCTestCase {
    private struct Pay: Codable {
        let method: Method
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Method.creditCard.rawValue, "credit_card")
        XCTAssertEqual(Method.paypal.rawValue, "paypal")
        XCTAssertEqual(Method.payUponInvoice.rawValue, "pay_upon_invoice")
        XCTAssertEqual(Method.carrier.rawValue, "carrier")
        XCTAssertEqual(Method.alternatePayment.rawValue, "alternate_payment")
        XCTAssertEqual(Method.bank.rawValue, "bank")
    }
    
    func testAllCase() {
        XCTAssertEqual(Method.allCases.count, 6)
        XCTAssertEqual(Method.allCases, [.creditCard, .paypal, .payUponInvoice, .carrier, .alternatePayment, .bank])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let creditCard = try String(data: encoder.encode(Pay(method: .creditCard)), encoding: .utf8)
        let paypal = try String(data: encoder.encode(Pay(method: .paypal)), encoding: .utf8)
        
        XCTAssertEqual(creditCard, "{\"method\":\"credit_card\"}")
        XCTAssertEqual(paypal, "{\"method\":\"paypal\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let payUponInvoice = """
        {
            "method": "pay_upon_invoice"
        }
        """.data(using: .utf8)!
        let carrier = """
        {
            "method": "carrier"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Pay.self, from: payUponInvoice).method, .payUponInvoice)
        try XCTAssertEqual(decoder.decode(Pay.self, from: carrier).method, .carrier)
    }
    
    static var allTests: [(String, (OrderPaymentMethodTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






