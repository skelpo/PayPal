import XCTest
@testable import PayPal

final class TransactionStateTests: XCTestCase {
    struct BillingTransaction: Codable {
        let state: Transaction.State
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Transaction.State.completed.rawValue, "Completed")
        XCTAssertEqual(Transaction.State.partiallyRefunded.rawValue, "Partially_Refunded")
        XCTAssertEqual(Transaction.State.pending.rawValue, "Pending")
        XCTAssertEqual(Transaction.State.refunded.rawValue, "Refunded")
        XCTAssertEqual(Transaction.State.denied.rawValue, "Denied")
    }
    
    func testAllCase() {
        XCTAssertEqual(Transaction.State.allCases.count, 5)
        XCTAssertEqual(Transaction.State.allCases, [.completed, .partiallyRefunded, .pending, .refunded, .denied])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let completed = try String(data: encoder.encode(BillingTransaction(state: .completed)), encoding: .utf8)
        let partiallyRefunded = try String(data: encoder.encode(BillingTransaction(state: .partiallyRefunded)), encoding: .utf8)
        
        XCTAssertEqual(completed, "{\"state\":\"Completed\"}")
        XCTAssertEqual(partiallyRefunded, "{\"state\":\"Partially_Refunded\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let pending = """
        {
            "state": "Pending"
        }
        """.data(using: .utf8)!
        let denied = """
        {
            "state": "Denied"
        }
        """
        
        try XCTAssertEqual(decoder.decode(BillingTransaction.self, from: pending).state, .pending)
        try XCTAssertEqual(decoder.decode(BillingTransaction.self, from: denied).state, .denied)
    }
    
    static var allTests: [(String, (TransactionStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


