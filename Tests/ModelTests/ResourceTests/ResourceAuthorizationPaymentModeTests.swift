import XCTest
@testable import PayPal

fileprivate typealias Mode = RelatedResource.Authorization.PaymentMode

public final class ResourceAuthorizationPaymentModeTests: XCTestCase {
    private struct Auth: Codable {
        let mode: Mode
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Mode.instant.rawValue, "INSTANT_TRANSFER")
    }
    
    func testAllCase() {
        XCTAssertEqual(Mode.allCases.count, 1)
        XCTAssertEqual(Mode.allCases, [.instant])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let instant = try String(data: encoder.encode(Auth(mode: .instant)), encoding: .utf8)
        XCTAssertEqual(instant, "{\"mode\":\"INSTANT_TRANSFER\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let instant = """
        {
            "mode": "INSTANT_TRANSFER"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Auth.self, from: instant).mode, .instant)
    }
    
    public static var allTests: [(String, (ResourceAuthorizationPaymentModeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}









