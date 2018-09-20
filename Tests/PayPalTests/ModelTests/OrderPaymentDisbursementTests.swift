import XCTest
@testable import PayPal

typealias Disbursement = Order.DisbursementMode

final class OrderPaymentDisbursementTests: XCTestCase {
    struct Or: Codable {
        let disbursement: Disbursement
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Disbursement.instant.rawValue, "INSTANT")
        XCTAssertEqual(Disbursement.delayed.rawValue, "DELAYED")
    }
    
    func testAllCase() {
        XCTAssertEqual(Disbursement.allCases.count, 2)
        XCTAssertEqual(Disbursement.allCases, [.instant, .delayed])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let instant = try String(data: encoder.encode(Or(disbursement: .instant)), encoding: .utf8)
        let delayed = try String(data: encoder.encode(Or(disbursement: .delayed)), encoding: .utf8)
        
        XCTAssertEqual(instant, "{\"disbursement\":\"INSTANT\"}")
        XCTAssertEqual(delayed, "{\"disbursement\":\"DELAYED\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let instant = """
        {
            "disbursement": "INSTANT"
        }
        """.data(using: .utf8)!
        let delayed = """
        {
            "disbursement": "DELAYED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Or.self, from: instant).disbursement, .instant)
        try XCTAssertEqual(decoder.decode(Or.self, from: delayed).disbursement, .delayed)
    }
    
    static var allTests: [(String, (OrderPaymentDisbursementTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
