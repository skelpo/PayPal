import XCTest
import Failable
@testable import PayPal

public final class PhoneNumberTests: XCTestCase {
    func testInit()throws {
        let number = try PhoneNumber(country: .init(1), number: .init(9963191901))
        
        XCTAssertEqual(number.country.value, 1)
        XCTAssertEqual(number.number.value, 9963191901)
    }
    
    func testValidations()throws {
        var number = try PhoneNumber(country: .init(1), number: .init(9963191901))
        
        try XCTAssertThrowsError(number.country <~ 1098)
        try XCTAssertThrowsError(number.number <~ 996319190112301)
        try number.country <~ 2
        try number.number <~ 2682814139
        
        XCTAssertEqual(number.country.value, 2)
        XCTAssertEqual(number.number.value, 2682814139)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(PhoneNumber(country: .init(1), number: .init(9963191901))), encoding: .utf8)
        
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
        try XCTAssertEqual(PhoneNumber(country: .init(1), number: .init(9963191901)), decoder.decode(PhoneNumber.self, from: json))
    }
    
    public static var allTests: [(String, (PhoneNumberTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




