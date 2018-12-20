import XCTest
@testable import PayPal

typealias CapStat = Capture.Status

final class CaptureStatusTests: XCTestCase {
    struct Cap: Codable {
        let status: CapStat
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(CapStat.pending.rawValue, "PENDING")
        XCTAssertEqual(CapStat.complete.rawValue, "COMPLETE")
        XCTAssertEqual(CapStat.refunded.rawValue, "REFUNDED")
        XCTAssertEqual(CapStat.partiallyRefunded.rawValue, "PARTIALLY_REFUNDED")
        XCTAssertEqual(CapStat.denied.rawValue, "DENIED")
        
    }
    
    func testAllCase() {
        XCTAssertEqual(CapStat.allCases.count, 5)
        XCTAssertEqual(CapStat.allCases, [.pending, .complete, .refunded, .partiallyRefunded, .denied])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let pending = try String(data: encoder.encode(Cap(status: .pending)), encoding: .utf8)
        let complete = try String(data: encoder.encode(Cap(status: .complete)), encoding: .utf8)
        
        XCTAssertEqual(pending, "{\"status\":\"PENDING\"}")
        XCTAssertEqual(complete, "{\"status\":\"COMPLETE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let refunded = """
        {
            "status": "REFUNDED"
        }
        """.data(using: .utf8)!
        let partiallyRefunded = """
        {
            "status": "PARTIALLY_REFUNDED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Cap.self, from: refunded).status, .refunded)
        try XCTAssertEqual(decoder.decode(Cap.self, from: partiallyRefunded).status, .partiallyRefunded)
    }
    
    static var allTests: [(String, (CaptureStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




