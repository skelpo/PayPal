import XCTest
@testable import PayPal

public final class TimelessDateTests: XCTestCase {
    func testInit()throws {
        let epoch = TimelessDate(date: "1970-01-01")
        let date: TimelessDate = 981_244_800.0
        
        XCTAssertNotNil(epoch)
        XCTAssertEqual(epoch?.timestamp, 0)
        XCTAssertEqual(date.timestamp, 981_244_800)
        XCTAssertEqual(TimelessDate.formatter.string(from: Date(timeIntervalSince1970: date.timestamp ?? 0)), "2001-02-04")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let date = ["date": TimelessDate(date: "2001-02-04")!]
        
        let generated = try String(data: encoder.encode(date), encoding: .utf8)
        let json = "{\"date\":\"2001-02-04\"}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "date": "2001-02-04"
        }
        """
        
        let date = ["date": TimelessDate(date: "2001-02-04")!]
        try XCTAssertEqual(date, decoder.decode([String: TimelessDate].self, from: json))
    }
    
    public static var allTests: [(String, (TimelessDateTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



