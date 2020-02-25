import XCTest
@testable import PayPal

public final class PayerInfoTests: XCTestCase {
    func testInit()throws {
        let info = PayerInfo(
            email: "payer@exmaple.com",
            shippingAddress: nil,
            billingAddress: Address(
                recipientName: "Puffin Billy",
                defaultAddress: true,
                line1: "89 Furnace Dr.",
                line2: nil,
                city: "Nowhere",
                state: .ks,
                country: .unitedStates,
                postalCode: "66167",
                phone: nil,
                type: nil
            )
        )
        
        XCTAssertEqual(info.id, nil)
        XCTAssertEqual(info.firstName, nil)
        XCTAssertEqual(info.lastName, nil)
        
        XCTAssertEqual(info.email, "payer@exmaple.com")
        XCTAssertEqual(info.shippingAddress, nil)
        XCTAssertEqual(
            info.billingAddress,
            Address(
                recipientName: "Puffin Billy",
                defaultAddress: true,
                line1: "89 Furnace Dr.",
                line2: nil,
                city: "Nowhere",
                state: .ks,
                country: .unitedStates,
                postalCode: "66167",
                phone: nil,
                type: nil
            )
        )
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let info = PayerInfo(
            email: "payer@exmaple.com",
            shippingAddress: nil,
            billingAddress: Address(
                recipientName: "Puffin Billy",
                defaultAddress: true,
                line1: "89 Furnace Dr.",
                line2: nil,
                city: "Nowhere",
                state: .ks,
                country: .unitedStates,
                postalCode: "66167",
                phone: nil,
                type: nil
            )
        )
        let generated = try String(data: encoder.encode(info), encoding: .utf8)!
        let json =
            "{\"email\":\"payer@exmaple.com\",\"billing_address\":{\"postal_code\":\"66167\",\"recipient_name\":\"Puffin Billy\",\"city\":\"Nowhere\"," +
            "\"country_code\":\"US\",\"line1\":\"89 Furnace Dr.\",\"default_address\":true,\"state\":\"KS\"}}"
        
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
        let info = PayerInfo(
            email: "payer@exmaple.com",
            shippingAddress: nil,
            billingAddress: Address(
                recipientName: "Puffin Billy",
                defaultAddress: true,
                line1: "89 Furnace Dr.",
                line2: nil,
                city: "Nowhere",
                state: .ks,
                country: .unitedStates,
                postalCode: "66167",
                phone: nil,
                type: nil
            )
        )
        let json = """
        {
            "email": "payer@exmaple.com",
            "billing_address": {
                "recipient_name": "Puffin Billy",
                "default_address": true,
                "line1": "89 Furnace Dr.",
                "city": "Nowhere",
                "state": "KS",
                "country_code": "US",
                "postal_code": "66167"
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(info, decoder.decode(PayerInfo.self, from: json))
    }
    
    public static var allTests: [(String, (PayerInfoTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

