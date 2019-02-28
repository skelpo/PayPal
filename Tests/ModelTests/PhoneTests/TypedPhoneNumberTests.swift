import XCTest
import Failable
@testable import PayPal

public final class TypedPhoneNumberTests: XCTestCase {
    func testInit()throws {
        let number = try TypedPhoneNumber(type: .home, country: .init(1), nationalNumber: .init(5838954290), extension: .init(777))
        
        XCTAssertEqual(number.type, .home)
        XCTAssertEqual(number.country.value, 1)
        XCTAssertEqual(number.extension.value, 777)
        XCTAssertEqual(number.nationalNumber.value, 5838954290)
    }
    
    func testValidations()throws {
        var number = try TypedPhoneNumber(type: .home, country: .init(1), nationalNumber: .init(5838954290), extension: .init(777))
        
        try XCTAssertThrowsError(number.country <~ 1234)
        try XCTAssertThrowsError(number.nationalNumber <~ 111_111_111_111_111)
        try XCTAssertThrowsError(number.`extension` <~ 1_111_111_111_111_111)
        
        try number.country <~ 123
        try number.nationalNumber <~ 11_111_111_111_111
        try number.`extension` <~ 111_111_111_111_111
        
        XCTAssertEqual(number.country.value, 123)
        XCTAssertEqual(number.nationalNumber.value, 11_111_111_111_111)
        XCTAssertEqual(number.`extension`.value, 111_111_111_111_111)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let number = try TypedPhoneNumber(type: .home, country: .init(1), nationalNumber: .init(5838954290), extension: .init(777))
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
            TypedPhoneNumber(type: .home, country: .init(1), nationalNumber: .init(5838954290), extension: .init(777))
        )
    }
    
    static var allTests: [(String, (TypedPhoneNumberTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




