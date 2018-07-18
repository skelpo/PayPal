import XCTest
@testable import PayPal

final class CreditCardStateTests: XCTestCase {
    struct CC: Codable {
        let state: CreditCardState
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(CreditCardState.ok.rawValue, "ok")
        XCTAssertEqual(CreditCardState.expired.rawValue, "expired")
    }
    
    func testAllCase() {
        XCTAssertEqual(CreditCardState.allCases.count, 2)
        XCTAssertEqual(CreditCardState.allCases, [.ok, .expired])
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
    
    static var allTests: [(String, (CreditCardStateTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




