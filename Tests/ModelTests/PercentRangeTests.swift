import XCTest
import Failable
@testable import PayPal

extension PercentRange {
    var array: [Index] {
        return self.map { $0 }
    }
}

public final class PercentRangeTests: XCTestCase {
    func testInit()throws {
        let range = try PercentRange(min: .init(25), max: .init(54))
        XCTAssertEqual(range.minimum.value, 25)
        XCTAssertEqual(range.maximum.value, 54)
        
        try XCTAssertEqual(PercentRange(min: .init(50), max: .init(75)).array, Array(50...75))
        try XCTAssertEqual(PercentRange(50...75).array, Array(50...75))
        try XCTAssertEqual(PercentRange(..<75).array, Array(0...74))
        try XCTAssertEqual(PercentRange(...75).array, Array(0...75))
        try XCTAssertEqual(PercentRange.init(50...).array, Array(50...100))
    }
    
    func testValidations()throws {
        var range = try PercentRange(min: .init(25), max: .init(75))
        
        try XCTAssertThrowsError(range.minimum <~ 100)
        try XCTAssertThrowsError(range.minimum <~ -1)
        try XCTAssertThrowsError(range.maximum <~ 101)
        try XCTAssertThrowsError(range.maximum <~ 0)
        try range.minimum <~ 0
        try range.maximum <~ 100
        
        XCTAssertEqual(range.minimum, 0)
        XCTAssertEqual(range.maximum, 100)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(PercentRange(min: 25, max: 75)), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"maximum_percent\":75,\"minimum_percent\":25}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "minimum_percent": 25,
            "maximum_percent": 75
        }
        """.data(using: .utf8)!
        let min = """
        {
            "minimum_percent": 100,
            "maximum_percent": 75
        }
        """.data(using: .utf8)!
        let max = """
        {
            "minimum_percent": 25,
            "maximum_percent": 0
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(PercentRange.self, from: min))
        try XCTAssertThrowsError(decoder.decode(PercentRange.self, from: max))
        try XCTAssertEqual(PercentRange(min: .init(25), max: .init(75)), decoder.decode(PercentRange.self, from: json))
    }
    
    public static var allTests: [(String, (PercentRangeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





