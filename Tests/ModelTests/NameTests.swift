import XCTest
import Failable
@testable import PayPal

public final class NameTests: XCTestCase {
    func testInit()throws {
        let name = try Name(
            prefix: .init("Sir"), given: .init("Walter"), surname: .init("Scott"), middle: nil, suffix: .init("auth."),
            full: .init("Sir Walter Scott")
        )
        
        XCTAssertNil(name.middle)
        XCTAssertEqual(name.prefix.value, "Sir")
        XCTAssertEqual(name.given.value, "Walter")
        XCTAssertEqual(name.surname.value, "Scott")
        XCTAssertEqual(name.suffix.value, "auth.")
        XCTAssertEqual(name.full.value, "Sir Walter Scott")
    }
    
    func testValidations()throws {
        var name = try Name(
            prefix: .init("Sir"), given: .init("Walter"), surname: .init("Scott"), middle: nil, suffix: .init("auth."),
            full: .init("Sir Walter Scott")
        )
        
        try XCTAssertThrowsError(name.prefix <~ String(repeating: "p", count: 141))
        try XCTAssertThrowsError(name.given <~ String(repeating: "g", count: 141))
        try XCTAssertThrowsError(name.surname <~ String(repeating: "s", count: 141))
        try XCTAssertThrowsError(name.middle <~ String(repeating: "m", count: 141))
        try XCTAssertThrowsError(name.suffix <~ String(repeating: "s", count: 141))
        try XCTAssertThrowsError(name.full <~ String(repeating: "f", count: 301))
        try name.full <~ String(repeating: "f", count: 300)
        
        XCTAssertEqual(name.full.value, String(repeating: "f", count: 300))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let name = try Name(
            prefix: .init("Sir"), given: .init("Walter"), surname: .init("Scott"), middle: nil, suffix: .init("auth."),
            full: .init("Sir Walter Scott")
        )
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
            "full_name": "\(String(repeating: "f", count: 301))",
        }
        """
        let suffix = """
        {
            "suffix": "\(String(repeating: "f", count: 141))"
        }
        """
        let surname = """
        {
            "surname": "\(String(repeating: "f", count: 141))"
        }
        """
        let middle = """
        {
            "middle_name": "\(String(repeating: "f", count: 141))"
        }
        """
        let given = """
        {
            "given_name": "\(String(repeating: "f", count: 141))"
        }
        """
        let prefix = """
        {
            "prefix": "\(String(repeating: "f", count: 141))"
        }
        """
        
        let name = try Name(
            prefix: .init("Sir"), given: .init("Walter"), surname: .init("Scott"), middle: nil, suffix: .init("auth."),
            full: .init("Sir Walter Scott")
        )
        
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


