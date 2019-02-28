import XCTest
@testable import PayPal

fileprivate typealias Intent = Order.Intent

public final class OrderIntentTests: XCTestCase {
    private struct Or: Codable {
        let intent: Intent
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Intent.sale.rawValue, "SALE")
        XCTAssertEqual(Intent.authorize.rawValue, "AUTHORIZE")
        XCTAssertEqual(Intent.capture.rawValue, "CAPTURE")
    }
    
    func testAllCase() {
        XCTAssertEqual(Intent.allCases.count, 3)
        XCTAssertEqual(Intent.allCases, [.sale, .authorize, .capture])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let sale = try String(data: encoder.encode(Or(intent: .sale)), encoding: .utf8)
        let authorize = try String(data: encoder.encode(Or(intent: .authorize)), encoding: .utf8)
        
        XCTAssertEqual(sale, "{\"intent\":\"SALE\"}")
        XCTAssertEqual(authorize, "{\"intent\":\"AUTHORIZE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let capture = """
        {
            "intent": "CAPTURE"
        }
        """.data(using: .utf8)!
        let authorize = """
        {
            "intent": "AUTHORIZE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Or.self, from: capture).intent, .capture)
        try XCTAssertEqual(decoder.decode(Or.self, from: authorize).intent, .authorize)
    }
    
    static var allTests: [(String, (OrderIntentTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




