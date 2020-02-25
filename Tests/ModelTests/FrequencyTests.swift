import XCTest
@testable import PayPal

public final class FrequencyTests: XCTestCase {
    struct Action: Codable {
        let frequency: Frequency
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Frequency.day.rawValue, "DAY")
        XCTAssertEqual(Frequency.week.rawValue, "WEEK")
        XCTAssertEqual(Frequency.month.rawValue, "MONTH")
        XCTAssertEqual(Frequency.year.rawValue, "YEAR")
    }
    
    func testAllCase() {
        XCTAssertEqual(Frequency.allCases.count, 4)
        XCTAssertEqual(Frequency.allCases, [.day, .week, .month, .year])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let day = try String(data: encoder.encode(Action(frequency: .day)), encoding: .utf8)
        let week = try String(data: encoder.encode(Action(frequency: .week)), encoding: .utf8)
        
        XCTAssertEqual(day, "{\"frequency\":\"DAY\"}")
        XCTAssertEqual(week, "{\"frequency\":\"WEEK\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let month = """
        {
            "frequency": "MONTH"
        }
        """.data(using: .utf8)!
        let year = """
        {
            "frequency": "YEAR"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Action.self, from: month).frequency, .month)
        try XCTAssertEqual(decoder.decode(Action.self, from: year).frequency, .year)
    }
    
    public static var allTests: [(String, (FrequencyTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



