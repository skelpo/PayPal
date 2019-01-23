import XCTest
@testable import PayPal

final class TransactionInfoStatusTests: XCTestCase {
    struct Request: Codable {
        let method: PayPal.Method
    }
    
    struct TI: Codable {
        let status: TransactionInfo.Status
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(TransactionInfo.Status.completed.rawValue, "COMPLETED")
        XCTAssertEqual(TransactionInfo.Status.unclaimed.rawValue, "UNCLAIMED")
        XCTAssertEqual(TransactionInfo.Status.denied.rawValue, "DENIED")
        XCTAssertEqual(TransactionInfo.Status.failed.rawValue, "FAILED")
        XCTAssertEqual(TransactionInfo.Status.held.rawValue, "HELD")
        XCTAssertEqual(TransactionInfo.Status.pending.rawValue, "PENDING")
        XCTAssertEqual(TransactionInfo.Status.partiallyRefunded.rawValue, "PARTIALLY_REFUNDED")
        XCTAssertEqual(TransactionInfo.Status.refunded.rawValue, "REFUNDED")
        XCTAssertEqual(TransactionInfo.Status.reversed.rawValue, "REVERSED")
    }
    
    func testAllCase() {
        XCTAssertEqual(TransactionInfo.Status.allCases.count, 9)
        XCTAssertEqual(TransactionInfo.Status.allCases, [.completed, .unclaimed, .denied, .failed, .held, .pending, .partiallyRefunded, .refunded, .reversed])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let partiallyRefunded = try String(data: encoder.encode(TI(status: .partiallyRefunded)), encoding: .utf8)
        let denied = try String(data: encoder.encode(TI(status: .denied)), encoding: .utf8)
        
        XCTAssertEqual(partiallyRefunded, "{\"status\":\"PARTIALLY_REFUNDED\"}")
        XCTAssertEqual(denied, "{\"status\":\"DENIED\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let failed = """
        {
            "status": "FAILED"
        }
        """.data(using: .utf8)!
        let reversed = """
        {
            "status": "REVERSED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(TI.self, from: failed).status, .failed)
        try XCTAssertEqual(decoder.decode(TI.self, from: reversed).status, .reversed)
    }
    
    static var allTests: [(String, (TransactionInfoStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


