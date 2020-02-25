import XCTest
@testable import PayPal

public final class AccountErrorDetailTests: XCTestCase {
    func testInit()throws {
        let details = AccountError.Details(issue: "1028", field: "property", value: "value", description: "Oops")
        
        XCTAssertEqual(details.issue, "1028")
        XCTAssertEqual(details.field, "property")
        XCTAssertEqual(details.value, "value")
        XCTAssertEqual(details.location, "body")
        XCTAssertEqual(details.description, "Oops")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let details = AccountError.Details(issue: "1028", field: "property", value: "value", description: "Oops")
        let generated = try String(data: encoder.encode(details), encoding: .utf8)!
        let json = "{\"location\":\"body\",\"value\":\"value\",\"description\":\"Oops\",\"issue\":\"1028\",\"field\":\"property\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let details = AccountError.Details(issue: "1028", field: "property", value: "value", description: "Oops")
        let json = """
        {
            "issue": "1028",
            "field": "property",
            "value": "value",
            "location": "body",
            "description": "Oops"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(details, decoder.decode(AccountError.Details.self, from: json))
    }
    
    public static var allTests: [(String, (AccountErrorDetailTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




