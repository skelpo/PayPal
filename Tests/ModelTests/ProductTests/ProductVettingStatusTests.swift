import XCTest
@testable import PayPal

private typealias Status = Product.VettingStatus

public final class ProductVettingStatusTests: XCTestCase {
    private struct Product: Codable {
        let status: Status
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Status.approved.rawValue, "APPROVED")
        XCTAssertEqual(Status.pending.rawValue, "PENDING")
        XCTAssertEqual(Status.declined.rawValue, "DECLINED")
    }
    
    func testAllCase() {
        XCTAssertEqual(Status.allCases.count, 3)
        XCTAssertEqual(Status.allCases, [.approved, .pending, .declined])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let approved = try String(data: encoder.encode(Product(status: .approved)), encoding: .utf8)
        let pending = try String(data: encoder.encode(Product(status: .pending)), encoding: .utf8)
        
        XCTAssertEqual(approved, "{\"status\":\"APPROVED\"}")
        XCTAssertEqual(pending, "{\"status\":\"PENDING\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let declined = """
        {
            "status": "DECLINED"
        }
        """.data(using: .utf8)!
        let approved = """
        {
            "status": "APPROVED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Product.self, from: declined).status, .declined)
        try XCTAssertEqual(decoder.decode(Product.self, from: approved).status, .approved)
    }
    
    static var allTests: [(String, (ProductVettingStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
