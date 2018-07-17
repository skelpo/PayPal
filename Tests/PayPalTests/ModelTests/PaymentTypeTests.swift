import XCTest
@testable import PayPal

final class PaymentTypeTests: XCTestCase {
    struct Pay: Codable {
        let type: PaymentType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(PaymentType.trial.rawValue, "TRIAL")
        XCTAssertEqual(PaymentType.regular.rawValue, "REGULAR")
    }
    
    func testAllCase() {
        XCTAssertEqual(PaymentType.allCases.count, 2)
        XCTAssertEqual(PaymentType.allCases, [.trial, .regular])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let trial = try String(data: encoder.encode(Pay(type: .trial)), encoding: .utf8)
        let regular = try String(data: encoder.encode(Pay(type: .regular)), encoding: .utf8)
        
        XCTAssertEqual(trial, "{\"type\":\"TRIAL\"}")
        XCTAssertEqual(regular, "{\"type\":\"REGULAR\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let trial = """
        {
            "type": "TRIAL"
        }
        """.data(using: .utf8)!
        let regular = """
        {
            "type": "REGULAR"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Pay.self, from: trial).type, .trial)
        try XCTAssertEqual(decoder.decode(Pay.self, from: regular).type, .regular)
    }
    
    static var allTests: [(String, (PaymentTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

