import XCTest
@testable import PayPal

final class PhoneNumberTests: XCTestCase {
    func testInit()throws {
        let number = try PhoneNumber(country: "1", number: "9963191901")
        
        XCTAssertEqual(number.country, "1")
        XCTAssertEqual(number.number, "9963191901")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(PhoneNumber(country: "1", number: "996319190112301"))
        try XCTAssertThrowsError(PhoneNumber(country: "1", number: ""))
        try XCTAssertThrowsError(PhoneNumber(country: "", number: "9963191901"))
        try XCTAssertThrowsError(PhoneNumber(country: "1098", number: "9963191901"))
        var number = try PhoneNumber(country: "1", number: "9963191901")
        
        try XCTAssertThrowsError(number.set(\.country <~ "1098"))
        try XCTAssertThrowsError(number.set(\.number <~ "996319190112301"))
        try number.set(\.country <~ "2")
        try number.set(\.number <~ "2682814139")
        
        XCTAssertEqual(number.country, "2")
        XCTAssertEqual(number.number, "2682814139")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(PhoneNumber(country: "1", number: "9963191901")), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"country_code\":\"1\",\"national_number\":\"9963191901\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "country_code": "1",
            "national_number": "9963191901"
        }
        """.data(using: .utf8)!
        let invalid = """
        {
            "country_code": "996319190112301",
            "national_number": "1"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(PhoneNumber.self, from: invalid))
        try XCTAssertEqual(PhoneNumber(country: "1", number: "9963191901"), decoder.decode(PhoneNumber.self, from: json))
    }
    
    static var allTests: [(String, (PhoneNumberTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




