import XCTest
@testable import PayPal

typealias Normalization = Address.Normalization

public final class AddressNormalizationTests: XCTestCase {
    struct Add: Codable {
        let norm: Normalization
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Normalization.unknown.rawValue, "UNKNOWN")
        XCTAssertEqual(Normalization.unnormalizedUserPrefered.rawValue, "UNNORMALIZED_USER_PREFERRED")
        XCTAssertEqual(Normalization.normalized.rawValue, "NORMALIZED")
        XCTAssertEqual(Normalization.unnormalized.rawValue, "UNNORMALIZED")
    }
    
    func testAllCase() {
        XCTAssertEqual(Normalization.allCases.count, 4)
        XCTAssertEqual(Normalization.allCases, [.unknown, .unnormalizedUserPrefered, .normalized, .unnormalized])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let unknown = try String(data: encoder.encode(Add(norm: .unknown)), encoding: .utf8)
        let unnormalizedUserPrefered = try String(data: encoder.encode(Add(norm: .unnormalizedUserPrefered)), encoding: .utf8)
        
        XCTAssertEqual(unknown, "{\"norm\":\"UNKNOWN\"}")
        XCTAssertEqual(unnormalizedUserPrefered, "{\"norm\":\"UNNORMALIZED_USER_PREFERRED\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let normalized = """
        {
            "norm": "NORMALIZED"
        }
        """.data(using: .utf8)!
        let unnormalized = """
        {
            "norm": "UNNORMALIZED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Add.self, from: normalized).norm, .normalized)
        try XCTAssertEqual(decoder.decode(Add.self, from: unnormalized).norm, .unnormalized)
    }
    
    public static var allTests: [(String, (AddressNormalizationTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
