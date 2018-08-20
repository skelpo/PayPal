import XCTest
@testable import PayPal

final class BusinessOwnerIDTests: XCTestCase {
    func testInit()throws {
        let id = try BusinessOwner.ID(
            type: .driversLicense,
            value: "123abc456def",
            masked: false,
            issuerCountry: "US",
            issuerState: "OR",
            issuerCity: "Portland",
            placeOfIssue: nil,
            description: "DMV"
        )
        
        XCTAssertNil(id.placeOfIssue)
        XCTAssertEqual(id.type, .driversLicense)
        XCTAssertEqual(id.value, "123abc456def")
        XCTAssertEqual(id.masked, false)
        XCTAssertEqual(id.issuerCountry, "US")
        XCTAssertEqual(id.issuerState, "OR")
        XCTAssertEqual(id.issuerCity, "Portland")
        XCTAssertEqual(id.description, "DMV")
    }
    
    func testValueValidation()throws {
        try XCTAssertThrowsError(BusinessOwner.ID(
            type: .cpf,
            value: "123abc456def",
            masked: nil,
            issuerCountry: "usa",
            issuerState: nil,
            issuerCity: nil,
            placeOfIssue: nil,
            description: nil
        ))
        var id = try BusinessOwner.ID(
            type: .driversLicense,
            value: "123abc456def",
            masked: false,
            issuerCountry: "US",
            issuerState: "OR",
            issuerCity: "Portland",
            placeOfIssue: nil,
            description: "DMV"
        )
        
        try XCTAssertThrowsError(id.set(\.issuerCountry <~ "usa"))
        try id.set(\.issuerCountry <~ "UN")
        
        XCTAssertEqual(id.issuerCountry, "UN")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let id = try BusinessOwner.ID(
            type: .driversLicense,
            value: "123abc456def",
            masked: false,
            issuerCountry: "US",
            issuerState: "OR",
            issuerCity: "Portland",
            placeOfIssue: nil,
            description: "DMV"
        )
        let generated = try String(data: encoder.encode(id), encoding: .utf8)!
        let json =
            "{\"issuer_state\":\"OR\",\"masked\":false,\"issuer_city\":\"Portland\",\"issuer_description\":\"DMV\",\"value\":\"123abc456def\"," +
            "\"type\":\"DRIVERS_LICENSE\",\"issuer_country_code\":\"US\"}"
        
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
        
        let id = try BusinessOwner.ID(
            type: .driversLicense,
            value: "123abc456def",
            masked: false,
            issuerCountry: "US",
            issuerState: "OR",
            issuerCity: "Portland",
            placeOfIssue: nil,
            description: "DMV"
        )
        let json = """
        {
            "type": "DRIVERS_LICENSE",
            "value": "123abc456def",
            "masked": false,
            "issuer_country_code": "US",
            "issuer_state": "OR",
            "issuer_city": "Portland",
            "issuer_description": "DMV"
        }
        """.data(using: .utf8)!
        
        let country = """
        {
            "type": "DRIVERS_LICENSE",
            "value": "123abc456def",
            "masked": false,
            "issuer_country_code": "usa",
            "issuer_state": "OR".
            "issuer_city": "Portland",
            "issuer_description": "DMV"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(id, decoder.decode(BusinessOwner.ID.self, from: json))
        try XCTAssertThrowsError(decoder.decode(BusinessOwner.ID.self, from: country))
    }
    
    static var allTests: [(String, (BusinessOwnerIDTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



