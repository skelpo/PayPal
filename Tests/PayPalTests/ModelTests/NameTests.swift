import XCTest
@testable import PayPal

final class NameTests: XCTestCase {
    func testInit()throws {
        let name = try Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "auth.", full: "Sir Walter Scott")
        
        XCTAssertNil(name.middle)
        XCTAssertEqual(name.prefix, "Sir")
        XCTAssertEqual(name.given, "Walter")
        XCTAssertEqual(name.surname, "Scott")
        XCTAssertEqual(name.suffix, "auth.")
        XCTAssertEqual(name.full, "Sir Walter Scott")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Name(prefix: String(repeating: "p", count: 141), given: nil, surname: nil, middle: nil, suffix: nil, full: nil))
        try XCTAssertThrowsError(Name(prefix: nil, given: String(repeating: "g", count: 141), surname: nil, middle: nil, suffix: nil, full: nil))
        try XCTAssertThrowsError(Name(prefix: nil, given: nil, surname: String(repeating: "s", count: 141), middle: nil, suffix: nil, full: nil))
        try XCTAssertThrowsError(Name(prefix: nil, given: nil, surname: nil, middle: String(repeating: "m", count: 141), suffix: nil, full: nil))
        try XCTAssertThrowsError(Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: String(repeating: "p", count: 141), full: nil))
        try XCTAssertThrowsError(Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: String(repeating: "f", count: 301)))
        var name = try Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "auth.", full: "Sir Walter Scott")
        
        try XCTAssertThrowsError(name.set(\Name.prefix <~ String(repeating: "p", count: 141)))
        try XCTAssertThrowsError(name.set(\Name.given <~ String(repeating: "g", count: 141)))
        try XCTAssertThrowsError(name.set(\Name.surname <~ String(repeating: "s", count: 141)))
        try XCTAssertThrowsError(name.set(\Name.middle <~ String(repeating: "m", count: 141)))
        try XCTAssertThrowsError(name.set(\Name.suffix <~ String(repeating: "s", count: 141)))
        try XCTAssertThrowsError(name.set(\Name.full <~ String(repeating: "f", count: 301)))
        try name.set(\Name.full <~ String(repeating: "f", count: 300))
        
        XCTAssertEqual(name.full, String(repeating: "f", count: 300))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let name = try Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "auth.", full: "Sir Walter Scott")
        let generated = try String(data: encoder.encode(name), encoding: .utf8)
        let json = "{\"given_name\":\"Walter\",\"full_name\":\"Sir Walter Scott\",\"prefix\":\"Sir\",\"surname\":\"Scott\",\"suffix\":\"auth.\"}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "full_name": "Sir Walter Scott",
            "suffix": "auth.",
            "surname": "Scott",
            "given_name": "Walter",
            "prefix": "Sir"
        }
        """
        let full = """
        {
            "full_name": "Sir Walter Scott",
        }
        """
        let suffix = """
        {
            "suffix": "auth."
        }
        """
        let surname = """
        {
            "surname": "Scott"
        }
        """
        let middle = """
        {
            "middle_name": "Unknown"
        }
        """
        let given = """
        {
            "given_name": "Walter"
        }
        """
        let prefix = """
        {
            "prefix": "Sir"
        }
        """
        
        let name = try Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "auth.", full: "Sir Walter Scott")
        
        try XCTAssertEqual(name, decoder.decode(Name.self, from: json))
        try XCTAssertThrowsError(decoder.decode(Name.self, from: full))
        try XCTAssertThrowsError(decoder.decode(Name.self, from: suffix))
        try XCTAssertThrowsError(decoder.decode(Name.self, from: surname))
        try XCTAssertThrowsError(decoder.decode(Name.self, from: middle))
        try XCTAssertThrowsError(decoder.decode(Name.self, from: given))
        try XCTAssertThrowsError(decoder.decode(Name.self, from: prefix))
    }
    
    static var allTests: [(String, (NameTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


