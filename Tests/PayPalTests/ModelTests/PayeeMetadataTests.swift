import XCTest
@testable import PayPal

final class PayeeMetadataTests: XCTestCase {
    func testInit()throws {
        let metadata = try Payee.Metadata(
            email: "payee@example.com",
            phone: DisplayPhone(country: .unitedStates, number: "423981155636432"),
            brand: "Example Inc."
        )
        
        XCTAssertEqual(metadata.email, "payee@example.com")
        XCTAssertEqual(metadata.brand, "Example Inc.")
        XCTAssertEqual(metadata.phone, DisplayPhone(country: .unitedStates, number: "423981155636432"))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Payee.Metadata(
            email: String(repeating: "e", count: 128),
            phone: DisplayPhone(country: .unitedStates, number: "423981155636432"),
            brand: "Example Inc."
        ))
        var metadata = try Payee.Metadata(
            email: "payee@example.com",
            phone: DisplayPhone(country: .unitedStates, number: "423981155636432"),
            brand: "Example Inc."
        )
        
        try XCTAssertThrowsError(metadata.set(\Payee.Metadata.email <~ String(repeating: "e", count: 128)))
        try metadata.set(\Payee.Metadata.email <~ String(repeating: "e", count: 127))
        
        XCTAssertEqual(metadata.email, String(repeating: "e", count: 127))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let metadata = try Payee.Metadata(
            email: "payee@example.com",
            phone: DisplayPhone(country: .unitedStates, number: "423981155636432"),
            brand: "Example Inc."
        )
        let generated = try String(data: encoder.encode(metadata), encoding: .utf8)!
        let json = "{\"email\":\"payee@example.com\",\"brand_name\":\"Example Inc.\",\"display_phone\":{\"country_code\":\"US\",\"number\":\"423981155636432\"}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "brand_name": "Example Inc.",
            "display_phone": {
                "country_code": "US",
                "number": "423981155636432"
            },
            "email": "payee@example.com"
        }
        """.data(using: .utf8)!
        let metadata = try Payee.Metadata(
            email: "payee@example.com",
            phone: DisplayPhone(country: .unitedStates, number: "423981155636432"),
            brand: "Example Inc."
        )
        
        try XCTAssertEqual(metadata, decoder.decode(Payee.Metadata.self, from: json))
    }
    
    static var allTests: [(String, (PayeeMetadataTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




