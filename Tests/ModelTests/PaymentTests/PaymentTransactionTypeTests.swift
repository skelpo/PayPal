import XCTest
@testable import PayPal

final class PaymentTransactionTypeTests: XCTestCase {
    struct Pay: Codable {
        let type: PaymentType
    }
    
    struct Transaction: Codable {
        let type: PaymentDetail.TransactionType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(PaymentDetail.TransactionType.sale.rawValue, "SALE")
        XCTAssertEqual(PaymentDetail.TransactionType.authorization.rawValue, "AUTHORIZATION")
        XCTAssertEqual(PaymentDetail.TransactionType.capture.rawValue, "CAPTURE")
    }
    
    func testAllCase() {
        XCTAssertEqual(PaymentDetail.TransactionType.allCases.count, 3)
        XCTAssertEqual(PaymentDetail.TransactionType.allCases, [.sale, .authorization, .capture])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let sale = try String(data: encoder.encode(Transaction(type: .sale)), encoding: .utf8)
        let authorization = try String(data: encoder.encode(Transaction(type: .authorization)), encoding: .utf8)
        
        XCTAssertEqual(sale, "{\"type\":\"SALE\"}")
        XCTAssertEqual(authorization, "{\"type\":\"AUTHORIZATION\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let capture = """
        {
            "type": "CAPTURE"
        }
        """.data(using: .utf8)!
        let sale = """
        {
            "type": "SALE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Transaction.self, from: capture).type, .capture)
        try XCTAssertEqual(decoder.decode(Transaction.self, from: sale).type, .sale)
    }
    
    static var allTests: [(String, (PaymentTransactionTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


