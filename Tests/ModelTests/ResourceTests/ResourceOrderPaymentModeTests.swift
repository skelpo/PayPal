import XCTest
@testable import PayPal

fileprivate typealias Mode = RelatedResource.Order.PaymentMode

final class ResourceOrderPaymentModeTests: XCTestCase {
    private struct Order: Codable {
        let mode: Mode
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Mode.instant.rawValue, "INSTANT_TRANSFER")
        XCTAssertEqual(Mode.manual.rawValue, "MANUAL_BANK_TRANSFER")
        XCTAssertEqual(Mode.delayed.rawValue, "DELAYED_TRANSFER")
        XCTAssertEqual(Mode.echeck.rawValue, "ECHECK")
    }
    
    func testAllCase() {
        XCTAssertEqual(Mode.allCases.count, 4)
        XCTAssertEqual(Mode.allCases, [.instant, .manual, .delayed, .echeck])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let instant = try String(data: encoder.encode(Order(mode: .instant)), encoding: .utf8)
        let manual = try String(data: encoder.encode(Order(mode: .manual)), encoding: .utf8)
        
        XCTAssertEqual(instant, "{\"mode\":\"INSTANT_TRANSFER\"}")
        XCTAssertEqual(manual, "{\"mode\":\"MANUAL_BANK_TRANSFER\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let delayed = """
        {
            "mode": "DELAYED_TRANSFER"
        }
        """.data(using: .utf8)!
        let echeck = """
        {
            "mode": "ECHECK"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Order.self, from: delayed).mode, .delayed)
        try XCTAssertEqual(decoder.decode(Order.self, from: echeck).mode, .echeck)
    }
    
    static var allTests: [(String, (ResourceOrderPaymentModeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}










