import XCTest
@testable import PayPal

fileprivate typealias Status = Order.Payer.Status

public final class OrderPaymentStatusTests: XCTestCase {
    private struct Pay: Codable {
        let status: Status
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Status.verified.rawValue, "VERIFIED")
        XCTAssertEqual(Status.unverified.rawValue, "UNVERIFIED")
    }
    
    func testAllCase() {
        XCTAssertEqual(Status.allCases.count, 2)
        XCTAssertEqual(Status.allCases, [.verified, .unverified])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let verified = try String(data: encoder.encode(Pay(status: .verified)), encoding: .utf8)
        let unverified = try String(data: encoder.encode(Pay(status: .unverified)), encoding: .utf8)
        
        XCTAssertEqual(verified, "{\"status\":\"VERIFIED\"}")
        XCTAssertEqual(unverified, "{\"status\":\"UNVERIFIED\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let verified = """
        {
            "status": "VERIFIED"
        }
        """.data(using: .utf8)!
        let unverified = """
        {
            "status": "UNVERIFIED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Pay.self, from: verified).status, .verified)
        try XCTAssertEqual(decoder.decode(Pay.self, from: unverified).status, .unverified)
    }
    
    static var allTests: [(String, (OrderPaymentStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}







