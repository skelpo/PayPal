import XCTest
@testable import PayPal

final class PaymentMethodTests: XCTestCase {
    struct Pay: Codable {
        let method: PaymentMethod
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(PaymentMethod.bank.rawValue, "bank")
        XCTAssertEqual(PaymentMethod.paypal.rawValue, "paypal")
    }
    
    func testAllCase() {
        XCTAssertEqual(PaymentMethod.allCases.count, 2)
        XCTAssertEqual(PaymentMethod.allCases, [.bank, .paypal])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let bank = try String(data: encoder.encode(Pay(method: .bank)), encoding: .utf8)
        let paypal = try String(data: encoder.encode(Pay(method: .paypal)), encoding: .utf8)
        
        XCTAssertEqual(bank, "{\"method\":\"bank\"}")
        XCTAssertEqual(paypal, "{\"method\":\"paypal\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let bank = """
        {
            "method": "bank"
        }
        """.data(using: .utf8)!
        let paypal = """
        {
            "method": "paypal"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Pay.self, from: bank).method, .bank)
        try XCTAssertEqual(decoder.decode(Pay.self, from: paypal).method, .paypal)
    }
    
    static var allTests: [(String, (PaymentMethodTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





