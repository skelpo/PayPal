import XCTest
@testable import PayPal

typealias UnitStat = Order.Unit.Status

public final class OrderUnitStatusTests: XCTestCase {
    struct Unit: Codable {
        let status: UnitStat
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(UnitStat.notProcessed.rawValue, "NOT_PROCESSED")
        XCTAssertEqual(UnitStat.pending.rawValue, "PENDING")
        XCTAssertEqual(UnitStat.voided.rawValue, "VOIDED")
        XCTAssertEqual(UnitStat.authorized.rawValue, "AUTHORIZED")
        XCTAssertEqual(UnitStat.captured.rawValue, "CAPTURED")
    }
    
    func testAllCase() {
        XCTAssertEqual(UnitStat.allCases.count, 5)
        XCTAssertEqual(UnitStat.allCases, [.notProcessed, .pending, .voided, .authorized, .captured])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let pending = try String(data: encoder.encode(Unit(status: .pending)), encoding: .utf8)
        let voided = try String(data: encoder.encode(Unit(status: .voided)), encoding: .utf8)
        
        XCTAssertEqual(pending, "{\"status\":\"PENDING\"}")
        XCTAssertEqual(voided, "{\"status\":\"VOIDED\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let notProcessed = """
        {
            "status": "NOT_PROCESSED"
        }
        """.data(using: .utf8)!
        let captured = """
        {
            "status": "CAPTURED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Unit.self, from: notProcessed).status, .notProcessed)
        try XCTAssertEqual(decoder.decode(Unit.self, from: captured).status, .captured)
    }
    
    static var allTests: [(String, (OrderUnitStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}







