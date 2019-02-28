import XCTest
@testable import PayPal

fileprivate typealias State = RelatedResource.Sale.State

public final class PaymentSaleStateTests: XCTestCase {
    private struct Sale: Codable {
        let state: State
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(State.completed.rawValue, "completed")
        XCTAssertEqual(State.partiallyRefunded.rawValue, "partially_refunded")
        XCTAssertEqual(State.pending.rawValue, "pending")
        XCTAssertEqual(State.refunded.rawValue, "refunded")
        XCTAssertEqual(State.denied.rawValue, "denied")
    }
    
    func testAllCase() {
        XCTAssertEqual(State.allCases.count, 5)
        XCTAssertEqual(State.allCases, [.completed, .partiallyRefunded, .pending, .refunded, .denied])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let completed = try String(data: encoder.encode(Sale(state: .completed)), encoding: .utf8)
        let partiallyRefunded = try String(data: encoder.encode(Sale(state: .partiallyRefunded)), encoding: .utf8)
        
        XCTAssertEqual(completed, "{\"state\":\"completed\"}")
        XCTAssertEqual(partiallyRefunded, "{\"state\":\"partially_refunded\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let pending = """
        {
            "state": "pending"
        }
        """.data(using: .utf8)!
        let refunded = """
        {
            "state": "refunded"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Sale.self, from: pending).state, .pending)
        try XCTAssertEqual(decoder.decode(Sale.self, from: refunded).state, .refunded)
    }
    
    static var allTests: [(String, (PaymentSaleStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
