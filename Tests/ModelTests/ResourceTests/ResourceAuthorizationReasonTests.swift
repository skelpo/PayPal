import XCTest
@testable import PayPal

fileprivate typealias Reason = RelatedResource.Authorization.Reason

public final class ResourceAuthorizationReasonTests: XCTestCase {
    private struct Auth: Codable {
        let reason: Reason
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Reason.authorization.rawValue, "AUTHORIZATION")
    }
    
    func testAllCase() {
        XCTAssertEqual(Reason.allCases.count, 1)
        XCTAssertEqual(Reason.allCases, [.authorization])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let authorization = try String(data: encoder.encode(Auth(reason: .authorization)), encoding: .utf8)
        XCTAssertEqual(authorization, "{\"reason\":\"AUTHORIZATION\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let authorization = """
        {
            "reason": "AUTHORIZATION"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Auth.self, from: authorization).reason, .authorization)
    }
    
    public static var allTests: [(String, (ResourceAuthorizationReasonTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}










