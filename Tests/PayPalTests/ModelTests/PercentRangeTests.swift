import XCTest
@testable import PayPal

extension PercentRange {
    var array: [Index] {
        return self.map { $0 }
    }
}

final class PercentRangeTests: XCTestCase {
    func testInit()throws {
        let range = try PercentRange(min: 25, max: 54)
        XCTAssertEqual(range.minimum, 25)
        XCTAssertEqual(range.maximum, 54)
        
        try XCTAssertEqual(PercentRange(min: 50, max: 75).array, Array(50...75))
        try XCTAssertEqual(PercentRange(50...75).array, Array(50...75))
        try XCTAssertEqual(PercentRange(..<75).array, Array(0...74))
        try XCTAssertEqual(PercentRange(...75).array, Array(0...75))
        try XCTAssertEqual(PercentRange.init(50...).array, Array(50...100))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(PercentRange(min: -1, max: 54))
        try XCTAssertThrowsError(PercentRange(min: 100, max: 54))
        try XCTAssertThrowsError(PercentRange(min: 0, max: 101))
        try XCTAssertThrowsError(PercentRange(min: 0, max: 0))
        var range = try PercentRange(min: 25, max: 75)
        
        try XCTAssertThrowsError(range.set(\.minimum <~ 100))
        try XCTAssertThrowsError(range.set(\.minimum <~ -1))
        try XCTAssertThrowsError(range.set(\.maximum <~ 101))
        try XCTAssertThrowsError(range.set(\.maximum <~ 0))
        try range.set(\.minimum <~ 0)
        try range.set(\.maximum <~ 100)
        
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
        try XCTAssertEqual(PercentRange(min: 25, max: 75), decoder.decode(PercentRange.self, from: json))
    }
    
    static var allTests: [(String, (PercentRangeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





