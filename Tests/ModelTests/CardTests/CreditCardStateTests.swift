import XCTest
@testable import PayPal

fileprivate typealias CCStaate = CreditCard.State

public final class CreditCardStateTests: XCTestCase {
    private struct CC: Codable {
        let state: CCStaate
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(CCStaate.ok.rawValue, "ok")
        XCTAssertEqual(CCStaate.expired.rawValue, "expired")
    }
    
    func testAllCase() {
        XCTAssertEqual(CCStaate.allCases.count, 2)
        XCTAssertEqual(CCStaate.allCases, [.ok, .expired])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let ok = try String(data: encoder.encode(CC(state: .ok)), encoding: .utf8)
        let expired = try String(data: encoder.encode(CC(state: .expired)), encoding: .utf8)
        
        XCTAssertEqual(ok, "{\"state\":\"ok\"}")
        XCTAssertEqual(expired, "{\"state\":\"expired\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let ok = """
        {
            "state": "ok"
        }
        """.data(using: .utf8)!
        let expired = """
        {
            "state": "expired"
        }
        """
        
        try XCTAssertEqual(decoder.decode(CC.self, from: ok).state, .ok)
        try XCTAssertEqual(decoder.decode(CC.self, from: expired).state, .expired)
    }
    
    public static var allTests: [(String, (CreditCardStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




