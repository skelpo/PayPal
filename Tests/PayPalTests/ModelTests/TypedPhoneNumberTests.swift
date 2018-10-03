import XCTest
@testable import PayPal

final class TypedPhoneNumberTests: XCTestCase {
    func testInit()throws {
        let number = try TypedPhoneNumber(type: .home, country: "1", nationalNumber: "5838954290", extension: "777")
        
        XCTAssertEqual(number.type, .home)
        XCTAssertEqual(number.country, "1")
        XCTAssertEqual(number.extension, "777")
        XCTAssertEqual(number.nationalNumber, "5838954290")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(TypedPhoneNumber(type: .home, country: "1234", nationalNumber: "5838954290", extension: "777"))
        try XCTAssertThrowsError(TypedPhoneNumber(type: .home, country: "1", nationalNumber: String(repeating: "1", count: 15), extension: "777"))
        try XCTAssertThrowsError(TypedPhoneNumber(type: .home, country: "1", nationalNumber: "5838954290", extension: String(repeating: "1", count: 16)))
        var number = try TypedPhoneNumber(type: .home, country: "1", nationalNumber: "5838954290", extension: "777")
        
        try XCTAssertThrowsError(number.set(\.country <~ "1234"))
        try XCTAssertThrowsError(number.set(\.nationalNumber <~ String(repeating: "1", count: 15)))
        try XCTAssertThrowsError(number.set(\TypedPhoneNumber.extension <~ String(repeating: "1", count: 16)))
        
        try number.set(\.country <~ "123")
        try number.set(\.nationalNumber <~ String(repeating: "1", count: 14))
        try number.set(\TypedPhoneNumber.extension <~ String(repeating: "1", count: 15))
        
        XCTAssertEqual(number.country, "123")
        XCTAssertEqual(number.nationalNumber, String(repeating: "1", count: 14))
        XCTAssertEqual(number.extension, String(repeating: "1", count: 15))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let number = try TypedPhoneNumber(type: .home, country: "1", nationalNumber: "5838954290", extension: "777")
        let generated = try String(data: encoder.encode(number), encoding: .utf8)
        let json = "{\"country_code\":\"1\",\"type\":\"HOME\",\"national_number\":\"5838954290\",\"extension_number\":\"777\"}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "type": "HOME",
            "country_code": "1",
            "national_number": "5838954290",
            "extension_number": "777"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(
            decoder.decode(TypedPhoneNumber.self, from: json),
            TypedPhoneNumber(type: .home, country: "1", nationalNumber: "5838954290", extension: "777")
        )
    }
    
    static var allTests: [(String, (TypedPhoneNumberTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




