import XCTest
@testable import PayPal

typealias SaleStat = Sale.Status

public final class SaleStatusTests: XCTestCase {
    struct Sal: Codable {
        let status: SaleStat
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(SaleStat.completed.rawValue, "COMPLETED")
        XCTAssertEqual(SaleStat.partiallyRefunded.rawValue, "PARTIALLY_REFUNDED")
        XCTAssertEqual(SaleStat.pending.rawValue, "PENDING")
        XCTAssertEqual(SaleStat.refunded.rawValue, "REFUNDED")
        XCTAssertEqual(SaleStat.denied.rawValue, "DENIED")
    }
    
    func testAllCase() {
        XCTAssertEqual(SaleStat.allCases.count, 5)
        XCTAssertEqual(SaleStat.allCases, [.completed, .partiallyRefunded, .pending, .refunded, .denied])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let completed = try String(data: encoder.encode(Sal(status: .completed)), encoding: .utf8)
        let partiallyRefunded = try String(data: encoder.encode(Sal(status: .partiallyRefunded)), encoding: .utf8)
        
        XCTAssertEqual(completed, "{\"status\":\"COMPLETED\"}")
        XCTAssertEqual(partiallyRefunded, "{\"status\":\"PARTIALLY_REFUNDED\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let pending = """
        {
            "status": "PENDING"
        }
        """.data(using: .utf8)!
        let refunded = """
        {
            "status": "REFUNDED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Sal.self, from: pending).status, .pending)
        try XCTAssertEqual(decoder.decode(Sal.self, from: refunded).status, .refunded)
    }
    
    public static var allTests: [(String, (SaleStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}







