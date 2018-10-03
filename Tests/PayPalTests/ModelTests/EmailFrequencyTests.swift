import XCTest
@testable import PayPal

typealias EmailFrequency =  NotificationOptions.EmailFrequency

final class EmailFrequencyTests: XCTestCase {
    struct Email: Codable {
        let frequency: NotificationOptions.EmailFrequency
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(EmailFrequency.default.rawValue, "DEFAULT")
        XCTAssertEqual(EmailFrequency.none.rawValue, "NONE")
    }
    
    func testAllCase() {
        XCTAssertEqual(EmailFrequency.allCases.count, 2)
        XCTAssertEqual(EmailFrequency.allCases, [.default, .none])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let `default` = try String(data: encoder.encode(Email(frequency: .default)), encoding: .utf8)
        let none = try String(data: encoder.encode(Email(frequency: .none)), encoding: .utf8)
        
        XCTAssertEqual(`default`, "{\"frequency\":\"DEFAULT\"}")
        XCTAssertEqual(none, "{\"frequency\":\"NONE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let none = """
        {
            "frequency": "NONE"
        }
        """.data(using: .utf8)!
        let `default` = """
        {
            "frequency": "DEFAULT"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Email.self, from: none).frequency, .none)
        try XCTAssertEqual(decoder.decode(Email.self, from: `default`).frequency, .default)
    }
    
    static var allTests: [(String, (EmailFrequencyTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




