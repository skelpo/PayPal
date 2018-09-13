import XCTest
@testable import PayPal

fileprivate typealias Status = Order.Status

final class OrderStatusTests: XCTestCase {
    private struct Or: Codable {
        let status: Status
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Status.created.rawValue, "CREATED")
        XCTAssertEqual(Status.approved.rawValue, "APPROVED")
        XCTAssertEqual(Status.completed.rawValue, "COMPLETED")
        XCTAssertEqual(Status.failed.rawValue, "FAILED")
    }
    
    func testAllCase() {
        XCTAssertEqual(Status.allCases.count, 4)
        XCTAssertEqual(Status.allCases, [.created, .approved, .completed, .failed])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let created = try String(data: encoder.encode(Or(status: .created)), encoding: .utf8)
        let approved = try String(data: encoder.encode(Or(status: .approved)), encoding: .utf8)
        
        XCTAssertEqual(created, "{\"status\":\"CREATED\"}")
        XCTAssertEqual(approved, "{\"status\":\"APPROVED\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let completed = """
        {
            "status": "COMPLETED"
        }
        """.data(using: .utf8)!
        let failed = """
        {
            "status": "FAILED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Or.self, from: completed).status, .completed)
        try XCTAssertEqual(decoder.decode(Or.self, from: failed).status, .failed)
    }
    
    static var allTests: [(String, (OrderStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





