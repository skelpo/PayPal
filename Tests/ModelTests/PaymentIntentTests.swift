import XCTest
@testable import PayPal

fileprivate typealias Intent = Payment.Intent

final class PaymentIntentTests: XCTestCase {
    private struct Pay: Codable {
        let intent: Intent
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Intent.sale.rawValue, "sale")
        XCTAssertEqual(Intent.authorize.rawValue, "authorize")
        XCTAssertEqual(Intent.order.rawValue, "order")
    }
    
    func testAllCase() {
        XCTAssertEqual(Intent.allCases.count, 3)
        XCTAssertEqual(Intent.allCases, [.sale, .authorize, .order])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let sale = try String(data: encoder.encode(Pay(intent: .sale)), encoding: .utf8)
        let authorize = try String(data: encoder.encode(Pay(intent: .authorize)), encoding: .utf8)
        
        XCTAssertEqual(sale, "{\"intent\":\"sale\"}")
        XCTAssertEqual(authorize, "{\"intent\":\"authorize\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let order = """
        {
            "intent": "order"
        }
        """.data(using: .utf8)!
        let sale = """
        {
            "intent": "sale"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Pay.self, from: order).intent, .order)
        try XCTAssertEqual(decoder.decode(Pay.self, from: sale).intent, .sale)
    }
    
    static var allTests: [(String, (PaymentIntentTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






