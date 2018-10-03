import XCTest
@testable import PayPal

final class CreditCardTests: XCTestCase {
    func testInit()throws {
        let cc = try CreditCard(
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
        
        XCTAssertEqual(cc.id, nil)
        XCTAssertEqual(cc.state, nil)
        XCTAssertEqual(cc.validUntil, nil)
        XCTAssertEqual(cc.links, nil)
        
        XCTAssertEqual(cc.number, "4953912847443848")
        XCTAssertEqual(cc.type, "Visa")
        XCTAssertEqual(cc.expireMonth, 09)
        XCTAssertEqual(cc.expireYear, 2028)
        XCTAssertEqual(cc.ccv2, 633)
        XCTAssertEqual(cc.firstName, "Jonnas")
        XCTAssertEqual(cc.lastName, "Futher")
        XCTAssertEqual(cc.billingAddress, nil)
        XCTAssertEqual(cc.customerID, "5FC894A2-FDA7-416D-818F-C0678C57371F")
    }
    
    func testValidations()throws {
        var cc = try CreditCard(
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
        
        try XCTAssertThrowsError(CreditCard(
            number: "4953912847443848",
            type: "Visa",
            expireMonth: 13,
            expireYear: 2028,
            ccv2: 633,
            firstName: "Jonnas",
            lastName: "Futher",
            billingAddress: nil,
            customerID: "5FC894A2-FDA7-416D-818F-C0678C57371F"
        ))
        try XCTAssertThrowsError(CreditCard(
            number: "4953912847443848",
            type: "Visa",
            expireMonth: 09,
            expireYear: 31415,
            ccv2: 633,
            firstName: "Jonnas",
            lastName: "Futher",
            billingAddress: nil,
            customerID: "5FC894A2-FDA7-416D-818F-C0678C57371F"
        ))
        try XCTAssertThrowsError(CreditCard(
            number: "4953912847443848",
            type: "Visa",
            expireMonth: 09,
            expireYear: 2028,
            ccv2: 633,
            firstName: "Jonnas",
            lastName: "Futher",
            billingAddress: nil,
            customerID: String(repeating: "i", count: 257)
        ))
        
        
        try XCTAssertThrowsError(cc.set(\.expireMonth <~ 13))
        try XCTAssertThrowsError(cc.set(\.expireMonth <~ 0))
        try XCTAssertThrowsError(cc.set(\.expireYear <~ 18))
        try XCTAssertThrowsError(cc.set(\.expireYear <~ 31415))
        try XCTAssertThrowsError(cc.set(\CreditCard.customerID <~ String(repeating: "i", count: 257)))
        
        try cc.set(\.expireMonth <~ 12)
        try cc.set(\.expireYear <~ 2031)
        try cc.set(\.customerID <~ "2770367C-4E61-4E28-99D5-CD86902356A7")
        
        XCTAssertEqual(cc.expireMonth, 12)
        XCTAssertEqual(cc.expireYear, 2031)
        XCTAssertEqual(cc.customerID, "2770367C-4E61-4E28-99D5-CD86902356A7")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let cc = try CreditCard(
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
        let generated = try String(data: encoder.encode(cc), encoding: .utf8)!
        let json =
            "{\"number\":\"4953912847443848\",\"external_customer_id\":\"5FC894A2-FDA7-416D-818F-C0678C57371F\",\"expire_year\":2028,\"last_name\":\"Further\"," +
        "\"type\":\"Visa\",\"ccv2\":633,\"expire_month\":9,\"first_name\":\"Jonnas\"}"
        
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
        let cc = try CreditCard(
            number: "4953912847443848",
            type: "Visa",
            expireMonth: 09,
            expireYear: 2028,
            ccv2: 633,
            firstName: "Janner",
            lastName: "Wingfeather",
            billingAddress: nil,
            customerID: "5048DFA8-3E19-408E-A390-23FEF939AF2E"
        )
        let valid = """
        {
            "number": "4953912847443848",
            "type": "Visa",
            "expire_month": 9,
            "expire_year": 2028,
            "ccv2": 633,
            "first_name": "Janner",
            "last_name": "Wingfeather",
            "external_customer_id": "5048DFA8-3E19-408E-A390-23FEF939AF2E"
        }
        """.data(using: .utf8)!
        let monthFail = """
        {
            "number": "4953912847443848",
            "type": "Visa",
            "expire_month": 13,
            "expire_year": 2028,
            "ccv2": 633,
            "first_name": "Janner",
            "last_name": "Wingfeather",
            "external_customer_id": "5048DFA8-3E19-408E-A390-23FEF939AF2E"
        }
        """.data(using: .utf8)!
        let yearFail = """
        {
            "number": "4953912847443848",
            "type": "Visa",
            "expire_month": 9,
            "expire_year": 31415,
            "ccv2": 633,
            "first_name": "Janner",
            "last_name": "Wingfeather",
            "external_customer_id": "5048DFA8-3E19-408E-A390-23FEF939AF2E"
        }
        """.data(using: .utf8)!
        let customerFail = """
        {
            "number": "4953912847443848",
            "type": "Visa",
            "expire_month": 9,
            "expire_year": 2028,
            "ccv2": 633,
            "first_name": "Janner",
            "last_name": "Wingfeather",
            "external_customer_id": "\(String(repeating: "i", count: 257))"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(CreditCard.self, from: monthFail))
        try XCTAssertThrowsError(decoder.decode(CreditCard.self, from: yearFail))
        try XCTAssertThrowsError(decoder.decode(CreditCard.self, from: customerFail))
        try XCTAssertEqual(cc, decoder.decode(CreditCard.self, from: valid))
    }
    
    static var allTests: [(String, (CreditCardTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

