import XCTest
@testable import PayPal

final class OrderPayerInfoTests: XCTestCase {
    func testInit()throws {
        let info = try Order.Payer.Info(
            email: "email@example.com",
            birthdate: "2018-09-20T17:49:17+0000",
            tax: "85323EC0-A9114",
            taxType: .cpf,
            country: .unitedStates,
            billing: Address(
                recipientName: nil, defaultAddress: nil, line1: "Plum Fairy Ln.", line2: nil, city: "Ginger Planes", state: "CC",
                country: .wallisFutuna, postalCode: "3552", phone: nil, type: nil
            )
        )
        
        XCTAssertNil(info.salutation)
        XCTAssertNil(info.firstname)
        XCTAssertNil(info.middlename)
        XCTAssertNil(info.lastname)
        XCTAssertNil(info.suffix)
        XCTAssertNil(info.payer)
        
        XCTAssertEqual(info.email, "email@example.com")
        XCTAssertEqual(info.birthdate, "2018-09-20T17:49:17+0000")
        XCTAssertEqual(info.tax, "85323EC0-A9114")
        XCTAssertEqual(info.taxType, .cpf)
        XCTAssertEqual(info.country, .unitedStates)
        try XCTAssertEqual(info.billing, Address(
            recipientName: nil, defaultAddress: nil, line1: "Plum Fairy Ln.", line2: nil, city: "Ginger Planes", state: "CC",
            country: .wallisFutuna, postalCode: "3552", phone: nil, type: nil
        ))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(
            Order.Payer.Info(email: String(repeating: "e", count: 128), birthdate: nil, tax: nil, taxType: nil, country: nil, billing: nil)
        )
        try XCTAssertThrowsError(
            Order.Payer.Info(email: nil, birthdate: nil, tax: String(repeating: "t", count: 15), taxType: nil, country: nil, billing: nil)
        )
        var info = try Order.Payer.Info(
            email: "email@example.com",
            birthdate: "2018-09-20T17:49:17+0000",
            tax: "85323EC0-A9114",
            taxType: .cpf,
            country: .unitedStates,
            billing: Address(
                recipientName: nil, defaultAddress: nil, line1: "Plum Fairy Ln.", line2: nil, city: "Ginger Planes", state: "CC",
                country: .wallisFutuna, postalCode: "3552", phone: nil, type: nil
            )
        )
        
        try XCTAssertThrowsError(info.set(\Order.Payer.Info.email <~ String(repeating: "e", count: 128)))
        try XCTAssertThrowsError(info.set(\Order.Payer.Info.tax <~ String(repeating: "t", count: 15)))
        try info.set(\Order.Payer.Info.email <~ String(repeating: "e", count: 127))
        try info.set(\Order.Payer.Info.tax <~ String(repeating: "t", count: 14))
        
        
        XCTAssertEqual(info.email, String(repeating: "e", count: 127))
        XCTAssertEqual(info.tax, String(repeating: "t", count: 14))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let info = try Order.Payer.Info(
            email: "email@example.com",
            birthdate: "2018-09-20",
            tax: "85323EC0-A9114",
            taxType: .cpf,
            country: .unitedStates,
            billing: Address(
                recipientName: nil, defaultAddress: nil, line1: "Plum Fairy Ln.", line2: nil, city: "Ginger Planes", state: "CC",
                country: .wallisFutuna, postalCode: "3552", phone: nil, type: nil
            )
        )
        let generated = try String(data: encoder.encode(info), encoding: .utf8)!
        let json =
        "{\"email\":\"email@example.com\",\"tax_id\":\"85323EC0-A9114\",\"country_code\":\"US\",\"birth_date\":\"2018-09-20\",\"billing_address\":{\"country_code\":\"WF\",\"state\":\"CC\",\"line1\":\"Plum Fairy Ln.\",\"city\":\"Ginger Planes\",\"postal_code\":\"3552\"},\"tax_id_type\":\"BR_CPF\"}"
        
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
            "salutation": "Welcome",
            "first_name": "Cherry",
            "middle_name": "Wind",
            "last_name": "White",
            "suffix": "H.M.",
            "payer_id": "A8B9EE88-D7AF-4F8C-B6BC-70809F2DE8C1",
            "billing_address": {
                "postal_code": "3552",
                "city": "Ginger Planes",
                "country_code": "WF",
                "line1": "Plum Fairy Ln.",
                "state": "CC"
            },
            "country_code": "US",
            "tax_id_type": "BR_CPF",
            "tax_id": "85323EC0-A9114",
            "birth_date": "2018-09-20",
            "email": "email@example.com"
        }
        """.data(using: .utf8)!
        
        let info = try decoder.decode(Order.Payer.Info.self, from: json)
        XCTAssertEqual(info.salutation, "Welcome")
        XCTAssertEqual(info.firstname, "Cherry")
        XCTAssertEqual(info.middlename, "Wind")
        XCTAssertEqual(info.lastname, "White")
        XCTAssertEqual(info.suffix, "H.M.")
        XCTAssertEqual(info.payer, "A8B9EE88-D7AF-4F8C-B6BC-70809F2DE8C1")
        XCTAssertEqual(info.country, .unitedStates)
        XCTAssertEqual(info.taxType, .cpf)
        XCTAssertEqual(info.tax, "85323EC0-A9114")
        XCTAssertEqual(info.birthdate, "2018-09-20")
        XCTAssertEqual(info.email, "email@example.com")
        try XCTAssertEqual(info.billing, Address(
            recipientName: nil, defaultAddress: nil, line1: "Plum Fairy Ln.", line2: nil, city: "Ginger Planes", state: "CC",
            country: .wallisFutuna, postalCode: "3552", phone: nil, type: nil
        ))
    }
    
    static var allTests: [(String, (OrderPayerInfoTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
