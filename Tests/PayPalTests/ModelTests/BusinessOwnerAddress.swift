import XCTest
@testable import PayPal

final class BusinessOwnerAddressTests: XCTestCase {
    func testInit()throws {
        let address = try BusinessOwner.Address(
            type: .home,
            line1: "89 Furnace Dr.",
            line2: nil,
            line3: nil,
            suburb: "Invisible Winds",
            city: "Nowhere",
            state: .ks,
            country: .unitedStates,
            postalCode: "66167"
        )
        
        XCTAssertNil(address.line2)
        XCTAssertNil(address.line3)
        XCTAssertEqual(address.type, .home)
        XCTAssertEqual(address.line1, "89 Furnace Dr.")
        XCTAssertEqual(address.suburb, "Invisible Winds")
        XCTAssertEqual(address.city, "Nowhere")
        XCTAssertEqual(address.state, .ks)
        XCTAssertEqual(address.country, .unitedStates)
        XCTAssertEqual(address.postalCode, "66167")
    }
    
    func testValueValidation()throws {
        try XCTAssertThrowsError(BusinessOwner.Address(
            type: .home,
            line1: String(repeating: "l", count: 301),
            line2: nil,
            line3: nil,
            suburb: "Invisible Winds",
            city: "Nowhere",
            state: .ks,
            country: .unitedStates,
            postalCode: "66167"
        ))
        try XCTAssertThrowsError(BusinessOwner.Address(
            type: .home,
            line1: "89 Furnace Dr.",
            line2: String(repeating: "l", count: 301),
            line3: nil,
            suburb: "Invisible Winds",
            city: "Nowhere",
            state: .ks,
            country: .unitedStates,
            postalCode: "66167"
        ))
        try XCTAssertThrowsError(BusinessOwner.Address(
            type: .home,
            line1: "89 Furnace Dr.",
            line2: nil,
            line3: String(repeating: "l", count: 301),
            suburb: "Invisible Winds",
            city: "Nowhere",
            state: .ks,
            country: .unitedStates,
            postalCode: "66167"
        ))
        try XCTAssertThrowsError(BusinessOwner.Address(
            type: .home,
            line1: "89 Furnace Dr.",
            line2: nil,
            line3: nil,
            suburb: String(repeating: "l", count: 301),
            city: "Nowhere",
            state: .ks,
            country: .unitedStates,
            postalCode: "66167"
        ))
        try XCTAssertThrowsError(BusinessOwner.Address(
            type: .home,
            line1: "89 Furnace Dr.",
            line2: nil,
            line3: nil,
            suburb: "Invisible Winds",
            city: String(repeating: "l", count: 121),
            state: .ks,
            country: .unitedStates,
            postalCode: "66167"
        ))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let address = try BusinessOwner.Address(
            type: .home,
            line1: "89 Furnace Dr.",
            line2: nil,
            line3: nil,
            suburb: "Invisible Winds",
            city: "Nowhere",
            state: .ks,
            country: .unitedStates,
            postalCode: "66167"
        )
        let generated = try String(data: encoder.encode(address), encoding: .utf8)!
        let json =
            "{\"suburb\":\"Invisible Winds\",\"postal_code\":\"66167\",\"city\":\"Nowhere\",\"country_code\":\"US\",\"type\":\"HOME\"," +
            "\"line1\":\"89 Furnace Dr.\",\"state\":\"KS\"}"
        
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
        
        let address = try BusinessOwner.Address(
            type: .home,
            line1: "89 Furnace Dr.",
            line2: nil,
            line3: nil,
            suburb: "Invisible Winds",
            city: "Nowhere",
            state: .ks,
            country: .unitedStates,
            postalCode: "66167"
        )
        let json = """
        {
            "type": "HOME",
            "line1": "89 Furnace Dr.",
            "suburb": "Invisible Winds",
            "city": "Nowhere",
            "state": "KS",
            "country_code": "US",
            "postal_code": "66167"
        }
        """.data(using: .utf8)!
        
        let line1 = """
        {
            "type": "HOME",
            "line1": "\(String(repeating: "l", count: 301))",
            "city": "Nowhere",
            "country_code": "US"
        }
        """.data(using: .utf8)!
        let line2 = """
        {
            "type": "HOME",
            "line1": "89 Furnace Dr.",
            "line2": "\(String(repeating: "l", count: 301))",
            "city": "Nowhere",
            "country_code": "US"
        }
        """.data(using: .utf8)!
        let line3 = """
        {
            "type": "HOME",
            "line1": "89 Furnace Dr.",
            "line3": "\(String(repeating: "l", count: 301))",
            "suburb": "Invisible Winds",
            "city": "Nowhere",
            "state": "KS",
            "country_code": "US"
        }
        """.data(using: .utf8)!
        let suburb = """
        {
            "type": "HOME",
            "line1": "89 Furnace Dr.",
            "suburb": "\(String(repeating: "s", count: 301))",
            "city": "Nowhere",
            "country_code": "US"
        }
        """.data(using: .utf8)!
        let city = """
        {
            "type": "HOME",
            "line1": "89 Furnace Dr.",
            "city": "\(String(repeating: "l", count: 121))",
            "country_code": "US"
        }
        """.data(using: .utf8)!
        let state = """
        {
            "type": "HOME",
            "line1": "89 Furnace Dr.",
            "city": "Nowhere",
            "state": "\(String(repeating: "l", count: 41))",
            "country_code": "US"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(address, decoder.decode(BusinessOwner.Address.self, from: json))
        try XCTAssertThrowsError(decoder.decode(BusinessOwner.Address.self, from: line1))
        try XCTAssertThrowsError(decoder.decode(BusinessOwner.Address.self, from: line2))
        try XCTAssertThrowsError(decoder.decode(BusinessOwner.Address.self, from: line3))
        try XCTAssertThrowsError(decoder.decode(BusinessOwner.Address.self, from: suburb))
        try XCTAssertThrowsError(decoder.decode(BusinessOwner.Address.self, from: city))
        try XCTAssertThrowsError(decoder.decode(BusinessOwner.Address.self, from: state))
    }
    
    static var allTests: [(String, (BusinessOwnerAddressTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


