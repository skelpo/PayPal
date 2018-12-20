import XCTest
@testable import PayPal

fileprivate typealias Hold = Payment.HoldReason

final class PaymentHoldTests: XCTestCase {
    private struct Pay: Codable {
        let hold: Hold
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Hold.payment.rawValue, "PAYMENT_HOLD")
        XCTAssertEqual(Hold.shipping.rawValue, "SHIPPING_RISK_HOLD")
    }
    
    func testAllCase() {
        XCTAssertEqual(Hold.allCases.count, 2)
        XCTAssertEqual(Hold.allCases, [.payment, .shipping])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let payment = try String(data: encoder.encode(Pay(hold: .payment)), encoding: .utf8)
        let shipping = try String(data: encoder.encode(Pay(hold: .shipping)), encoding: .utf8)
        
        XCTAssertEqual(payment, "{\"hold\":\"PAYMENT_HOLD\"}")
        XCTAssertEqual(shipping, "{\"hold\":\"SHIPPING_RISK_HOLD\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let payment = """
        {
            "hold": "PAYMENT_HOLD"
        }
        """.data(using: .utf8)!
        let shipping = """
        {
            "hold": "SHIPPING_RISK_HOLD"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Pay.self, from: payment).hold, .payment)
        try XCTAssertEqual(decoder.decode(Pay.self, from: shipping).hold, .shipping)
    }
    
    static var allTests: [(String, (PaymentHoldTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}







