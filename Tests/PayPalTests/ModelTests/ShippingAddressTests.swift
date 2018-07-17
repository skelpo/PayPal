import XCTest
@testable import PayPal

final class ShippingAddressTests: XCTestCase {
    func testInit()throws {
        let address = try ShippingAddress(
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
        try XCTAssertThrowsError(ShippingAddress(
            recipientName: "Puffin Billy",
            defaultAddress: true,
            line1: "89 Furnace Dr.",
            line2: nil,
            city: "Nowhere",
            state: "KS",
            countryCode: "22",
            postalCode: "66167"
        ))
        try XCTAssertThrowsError(ShippingAddress(
            recipientName: "Puffin Billy",
            defaultAddress: true,
            line1: "89 Furnace Dr.",
            line2: nil,
            city: "Nowhere",
            state: "KS",
            countryCode: "USA",
            postalCode: "66167"
        ))
        try XCTAssertThrowsError(ShippingAddress(
            recipientName: "Puffin Billy",
            defaultAddress: true,
            line1: "89 Furnace Dr.",
            line2: nil,
            city: "Nowhere",
            state: String(repeating: "j", count: 41),
            countryCode: "US",
            postalCode: "66167"
        ))
        
        var test = try ShippingAddress(
            recipientName: "Puffin Billy",
            defaultAddress: true,
            line1: "89 Furnace Dr.",
            line2: nil,
            city: "Nowhere",
            state: "KS",
            countryCode: "US",
            postalCode: "66167"
        )
        
        try XCTAssertThrowsError(test.set(\ShippingAddress.state <~ String(repeating: "KS", count: 22)))
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
        let usd = try String(data: encoder.encode(Money(currency: .usd, value: "12.25")), encoding: .utf8)
        let xxx = try String(data: encoder.encode(Money(currency: .xxx, value: "0")), encoding: .utf8)
        let eur = try String(data: encoder.encode(Money(currency: .eur, value: "4.5")), encoding: .utf8)
        
        XCTAssertEqual(usd, "{\"value\":\"12.25\",\"currency_code\":\"USD\"}")
        XCTAssertEqual(xxx, "{\"value\":\"0\",\"currency_code\":\"XXX\"}")
        XCTAssertEqual(eur, "{\"value\":\"4.5\",\"currency_code\":\"EUR\"}")
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
        
        try XCTAssertThrowsError(decoder.decode(ShippingAddress.self, from: stateFail))
        try XCTAssertThrowsError(decoder.decode(ShippingAddress.self, from: countryCodeFail))
        try XCTAssertEqual(
            ShippingAddress(
                recipientName: "Puffin Billy",
                defaultAddress: true,
                line1: "89 Furnace Dr.",
                line2: nil,
                city: "Nowhere",
                state: "KS",
                countryCode: "US",
                postalCode: "66167"
            ),
            decoder.decode(ShippingAddress.self, from: valid)
        )
    }
    
    static var allTests: [(String, (ShippingAddressTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
