import XCTest
@testable import PayPal

fileprivate typealias Mode = RelatedResource.Sale.PaymentMode

final class PaymentSaleModeTests: XCTestCase {
    private struct Sale: Codable {
        let mode: Mode
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Mode.instantTransfer.rawValue, "INSTANT_TRANSFER")
        XCTAssertEqual(Mode.manualTransfer.rawValue, "MANUAL_BANK_TRANSFER")
        XCTAssertEqual(Mode.delayedTransfer.rawValue, "DELAYED_TRANSFER")
        XCTAssertEqual(Mode.echeck.rawValue, "ECHECK")
    }
    
    func testAllCase() {
        XCTAssertEqual(Mode.allCases.count, 4)
        XCTAssertEqual(Mode.allCases, [.instantTransfer, .manualTransfer, .delayedTransfer, .echeck])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let instantTransfer = try String(data: encoder.encode(Sale(mode: .instantTransfer)), encoding: .utf8)
        let manualTransfer = try String(data: encoder.encode(Sale(mode: .manualTransfer)), encoding: .utf8)
        
        XCTAssertEqual(instantTransfer, "{\"mode\":\"INSTANT_TRANSFER\"}")
        XCTAssertEqual(manualTransfer, "{\"mode\":\"MANUAL_BANK_TRANSFER\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let delayedTransfer = """
        {
            "mode": "DELAYED_TRANSFER"
        }
        """.data(using: .utf8)!
        let echeck = """
        {
            "mode": "ECHECK"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Sale.self, from: delayedTransfer).mode, .delayedTransfer)
        try XCTAssertEqual(decoder.decode(Sale.self, from: echeck).mode, .echeck)
    }
    
    static var allTests: [(String, (PaymentSaleModeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}








