import XCTest
@testable import PayPal

final class AddressTests: XCTestCase {
    func testInit()throws {
        let address = try Address(
            recipientName: "Puffin Billy",
            defaultAddress: true,
            line1: "89 Furnace Dr.",
            line2: nil,
            city: "Nowhere",
            state: "KS",
            countryCode: "US",
            postalCode: "66167"
        )
        
        XCTAssertEqual(address.recipientName, "Puffin Billy")
        XCTAssertEqual(address.defaultAddress, true)
        XCTAssertEqual(address.line1, "89 Furnace Dr.")
        XCTAssertEqual(address.line2, nil)
        XCTAssertEqual(address.city, "Nowhere")
        XCTAssertEqual(address.state, "KS")
        XCTAssertEqual(address.countryCode, "US")
        XCTAssertEqual(address.postalCode, "66167")
    }
    
    func testValueValidation()throws {
        try XCTAssertThrowsError(Address(
            recipientName: "Puffin Billy",
            defaultAddress: true,
            line1: "89 Furnace Dr.",
            line2: nil,
            city: "Nowhere",
            state: "KS",
            countryCode: "22",
            postalCode: "66167"
        ))
        try XCTAssertThrowsError(Address(
            recipientName: "Puffin Billy",
            defaultAddress: true,
            line1: "89 Furnace Dr.",
            line2: nil,
            city: "Nowhere",
            state: "KS",
            countryCode: "USA",
            postalCode: "66167"
        ))
        try XCTAssertThrowsError(Address(
            recipientName: "Puffin Billy",
            defaultAddress: true,
            line1: "89 Furnace Dr.",
            line2: nil,
            city: "Nowhere",
            state: String(repeating: "j", count: 41),
            countryCode: "US",
            postalCode: "66167"
        ))
        
        var test = try Address(
            recipientName: "Puffin Billy",
            defaultAddress: true,
            line1: "89 Furnace Dr.",
            line2: nil,
            city: "Nowhere",
            state: "KS",
            countryCode: "US",
            postalCode: "66167"
        )
        
        try XCTAssertThrowsError(test.set(\Address.state <~ String(repeating: "KS", count: 22)))
        try XCTAssertThrowsError(test.set(\.countryCode <~ "US@"))
        
        try test.set(\.state <~ "ON")
        try test.set(\.countryCode <~ "CA")
        test.city = "Somewhere"
        
        XCTAssertEqual(test.state, "ON")
        XCTAssertEqual(test.countryCode, "CA")
        XCTAssertEqual(test.city, "Somewhere")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let address = try Address(
            recipientName: "Puffin Billy",
            defaultAddress: true,
            line1: "89 Furnace Dr.",
            line2: nil,
            city: "Nowhere",
            state: "KS",
            countryCode: "US",
            postalCode: "66167"
        )
        
        let generated = try String(data: encoder.encode(address), encoding: .utf8)!
        let json =
            "{\"postal_code\":\"66167\",\"recipient_name\":\"Puffin Billy\",\"city\":\"Nowhere\"," +
            "\"country_code\":\"US\",\"line1\":\"89 Furnace Dr.\",\"default_address\":true,\"state\":\"KS\"}"
        
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
        let stateFail = """
        {
            "recipient_name": "Puffin Billy",
            "default_address": true,
            "line1": "89 Furnace Dr.",
            "city": "Nowhere",
            "state": "KSKSKSKSKSKSKSKSKSKSKSKSKSKSKSKSKSKSKSKSKSKS",
            "country_code": "US",
            "postal_code": "66167"
        }
        """.data(using: .utf8)!
        let countryCodeFail = """
        {
            "recipient_name": "Puffin Billy",
            "default_address": true,
            "line1": "89 Furnace Dr.",
            "city": "Nowhere",
            "state": "KS",
            "country_code": "USA",
            "postal_code": "66167"
        }
        """.data(using: .utf8)!
        let valid = """
        {
            "recipient_name": "Puffin Billy",
            "default_address": true,
            "line1": "89 Furnace Dr.",
            "city": "Nowhere",
            "state": "KS",
            "country_code": "US",
            "postal_code": "66167"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(Address.self, from: stateFail))
        try XCTAssertThrowsError(decoder.decode(Address.self, from: countryCodeFail))
        try XCTAssertEqual(
            Address(
                recipientName: "Puffin Billy",
                defaultAddress: true,
                line1: "89 Furnace Dr.",
                line2: nil,
                city: "Nowhere",
                state: "KS",
                countryCode: "US",
                postalCode: "66167"
            ),
            decoder.decode(Address.self, from: valid)
        )
    }
    
    static var allTests: [(String, (AddressTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
