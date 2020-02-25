import XCTest
@testable import PayPal

public final class PaymentDetailTypeTests: XCTestCase {
    struct Detail: Codable {
        let type: PaymentDetail.DetailType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(PaymentDetail.DetailType.paypal.rawValue, "PAYPAL")
        XCTAssertEqual(PaymentDetail.DetailType.external.rawValue, "EXTERNAL")
    }
    
    func testAllCase() {
        XCTAssertEqual(PaymentDetail.DetailType.allCases.count, 2)
        XCTAssertEqual(PaymentDetail.DetailType.allCases, [.paypal, .external])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let paypal = try String(data: encoder.encode(Detail(type: .paypal)), encoding: .utf8)
        let external = try String(data: encoder.encode(Detail(type: .external)), encoding: .utf8)
        
        XCTAssertEqual(paypal, "{\"type\":\"PAYPAL\"}")
        XCTAssertEqual(external, "{\"type\":\"EXTERNAL\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let paypal = """
        {
            "type": "PAYPAL"
        }
        """.data(using: .utf8)!
        let external = """
        {
            "type": "EXTERNAL"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Detail.self, from: paypal).type, .paypal)
        try XCTAssertEqual(decoder.decode(Detail.self, from: external).type, .external)
    }
    
    public static var allTests: [(String, (PaymentDetailTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






