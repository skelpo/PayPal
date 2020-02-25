import XCTest
import Failable
@testable import PayPal

public final class BusinessNameTests: XCTestCase {
    func testInit()throws {
        let name = try Business.Name(type: .legal, name: .init("Stuff and Nonsense Inc."))
        
        XCTAssertEqual(name.type, .legal)
        XCTAssertEqual(name.name.value, "Stuff and Nonsense Inc.")
    }
    
    func testValueValidation()throws {
        var name = try Business.Name(type: .legal, name: .init("Stuff and Nonsense Inc."))
        
        try XCTAssertThrowsError(name.name <~ String(repeating: "n", count: 301))
        try name.name <~ "Much Ado About Nothin' LLC."
        
        XCTAssertEqual(name.name.value, "Much Ado About Nothin' LLC.")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let name = try Business.Name(type: .legal, name: .init("Stuff and Nonsense Inc."))
        let generated = try String(data: encoder.encode(name), encoding: .utf8)!
        let json = "{\"type\":\"LEGAL\",\"name\":\"Stuff and Nonsense Inc.\"}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let name = try Business.Name(type: .legal, name: .init("Stuff and Nonsense Inc."))
        let json = """
        {
            "type": "LEGAL",
            "name": "Stuff and Nonsense Inc."
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(name, decoder.decode(Business.Name.self, from: json))
    }
    
    public static var allTests: [(String, (BusinessNameTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



