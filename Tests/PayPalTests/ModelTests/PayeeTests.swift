import XCTest
@testable import PayPal

final class PayeeTests: XCTestCase {
    func testInit()throws {
        let metadata = try Payee.Metadata(
            email: "payee@example.com",
            phone: DisplayPhone(country: .unitedStates, number: "423981155636432"),
            brand: "Example Inc."
        )
        let payee = Payee(email: "payee@example.com", merchant: "4B4E8CB5-A0A3-47C0-B53E-6CF99BAA59EE", metadata: metadata)
        
        XCTAssertEqual(payee.email, "payee@example.com")
        XCTAssertEqual(payee.merchant, "4B4E8CB5-A0A3-47C0-B53E-6CF99BAA59EE")
        XCTAssertEqual(payee.metadata, metadata)
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
    
    static var allTests: [(String, (PayeeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





