import XCTest
@testable import PayPal

final class TimelessDateTests: XCTestCase {
    func testInit()throws {
        let date = try TimelessDate(date: "1517-10-31")
        
        XCTAssertEqual(date.date, "1517-10-31")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(TimelessDate(date: "10/31/1517"))
        var date = try TimelessDate(date: "1517-10-31")
        
        try XCTAssertThrowsError(date.set(\.date <~ "11/20/2020"))
        try date.set(\.date <~ "2020-11-20")
        
        XCTAssertEqual(date.date, "2020-11-20")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let date = try TimelessDate(date: "1517-10-31")
        let generated = try String(data: encoder.encode(date), encoding: .utf8)
        let json = "{\"date_no_time\":\"1517-10-31\"}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "date_no_time": "1517-10-31"
        }
        """
        
        let date = try TimelessDate(date: "1517-10-31")
        try XCTAssertEqual(date, decoder.decode(TimelessDate.self, from: json))
    }
    
    static var allTests: [(String, (TimelessDateTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



