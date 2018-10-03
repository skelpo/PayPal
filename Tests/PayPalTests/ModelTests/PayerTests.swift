import XCTest
@testable import PayPal

final class PayerTests: XCTestCase {
    func testInit()throws {
        let payer = try Payer(
            method: .paypal,
            fundingInstruments: [
                CreditCard(
                    number: "4953912847443848",
                    type: "Visa",
                    expireMonth: 09,
                    expireYear: 2028,
                    ccv2: 633,
                    firstName: "Jonnas",
                    lastName: "Futher",
                    billingAddress: nil,
                    customerID: "5FC894A2-FDA7-416D-818F-C0678C57371F"
                )
            ],
            info: PayerInfo(
                email: "payer@exmaple.com",
                shippingAddress: nil,
                billingAddress: Address(
                    recipientName: "Puffin Billy",
                    defaultAddress: true,
                    line1: "89 Furnace Dr.",
                    line2: nil,
                    city: "Nowhere",
                    state: "KS",
                    countryCode: "US",
                    postalCode: "66167",
                    phone: nil,
                    type: nil
                )
            )
        )
        
        XCTAssertEqual(payer.fundingOption, nil)
        XCTAssertEqual(payer.method, .paypal)
        XCTAssertEqual(payer.fundingInstruments?.count, 1)
        try XCTAssertEqual(
            payer.fundingInstruments?.first,
            CreditCard(
                number: "4953912847443848",
                type: "Visa",
                expireMonth: 09,
                expireYear: 2028,
                ccv2: 633,
                firstName: "Jonnas",
                lastName: "Futher",
                billingAddress: nil,
                customerID: "5FC894A2-FDA7-416D-818F-C0678C57371F"
            )
        )
        try XCTAssertEqual(
            payer.info,
            PayerInfo(
                email: "payer@exmaple.com",
                shippingAddress: nil,
                billingAddress: Address(
                    recipientName: "Puffin Billy",
                    defaultAddress: true,
                    line1: "89 Furnace Dr.",
                    line2: nil,
                    city: "Nowhere",
                    state: "KS",
                    countryCode: "US",
                    postalCode: "66167",
                    phone: nil,
                    type: nil
                )
            )
        )
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let payer = try Payer(
            method: .paypal,
            fundingInstruments: [
                CreditCard(
                    number: "4953912847443848",
                    type: "Visa",
                    expireMonth: 09,
                    expireYear: 2028,
                    ccv2: 633,
                    firstName: "Jonnas",
                    lastName: "Further",
                    billingAddress: nil,
                    customerID: "5FC894A2-FDA7-416D-818F-C0678C57371F"
                )
            ],
            info: PayerInfo(
                email: "payer@exmaple.com",
                shippingAddress: nil,
                billingAddress: Address(
                    recipientName: "Puffin Billy",
                    defaultAddress: true,
                    line1: "89 Furnace Dr.",
                    line2: nil,
                    city: "Nowhere",
                    state: "KS",
                    countryCode: "US",
                    postalCode: "66167",
                    phone: nil,
                    type: nil
                )
            )
        )
        let generated = try String(data: encoder.encode(payer), encoding: .utf8)!
        let json =
            "{\"payment_method\":\"paypal\"," +
            "\"funding_instruments\":[{\"number\":\"4953912847443848\",\"external_customer_id\":\"5FC894A2-FDA7-416D-818F-C0678C57371F\"," +
            "\"expire_year\":2028,\"last_name\":\"Further\",\"type\":\"Visa\",\"ccv2\":633,\"expire_month\":9,\"first_name\":\"Jonnas\"}]," +
            "\"payer_info\":{\"email\":\"payer@exmaple.com\",\"billing_address\":{\"postal_code\":\"66167\",\"recipient_name\":\"Puffin Billy\"," +
            "\"city\":\"Nowhere\",\"country_code\":\"US\",\"line1\":\"89 Furnace Dr.\",\"default_address\":true,\"state\":\"KS\"}}}"
        
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
        let payer = try Payer(
            method: .paypal,
            fundingInstruments: [
                CreditCard(
                    number: "4953912847443848",
                    type: "Visa",
                    expireMonth: 09,
                    expireYear: 2028,
                    ccv2: 633,
                    firstName: "Jonnas",
                    lastName: "Futher",
                    billingAddress: nil,
                    customerID: "5FC894A2-FDA7-416D-818F-C0678C57371F"
                )
            ],
            info: PayerInfo(
                email: "payer@exmaple.com",
                shippingAddress: nil,
                billingAddress: Address(
                    recipientName: "Puffin Billy",
                    defaultAddress: true,
                    line1: "89 Furnace Dr.",
                    line2: nil,
                    city: "Nowhere",
                    state: "KS",
                    countryCode: "US",
                    postalCode: "66167",
                    phone: nil,
                    type: nil
                )
            )
        )
        let json = """
        {
            "payment_method": "paypal",
            "funding_instruments": [
                {
                    "number": "4953912847443848",
                    "type": "Visa",
                    "expire_month": 9,
                    "expire_year": 2028,
                    "ccv2": 633,
                    "first_name": "Jonnas",
                    "last_name": "Futher",
                    "external_customer_id": "5FC894A2-FDA7-416D-818F-C0678C57371F"
                }
            ],
            "payer_info": {
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
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(payer, decoder.decode(Payer.self, from: json))
    }
    
    static var allTests: [(String, (PayerTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


