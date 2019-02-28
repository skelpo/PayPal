import XCTest
import Failable
@testable import PayPal

public final class OrderPayerInfoTests: XCTestCase {
    let birthdate = Date()
    
    func testInit()throws {
        let info = try Order.Payer.Info(
            email: .init("email@example.com"),
            birthdate: self.birthdate,
            tax: .init("85323EC0-A9114"),
            taxType: .cpf,
            country: .unitedStates,
            billing: Address(
                recipientName: nil, defaultAddress: nil, line1: "Plum Fairy Ln.", line2: nil, city: "Ginger Planes", state: .le,
                country: .wallisAndFutuna, postalCode: "3552", phone: nil, type: nil
            )
        )
        
        XCTAssertNil(info.salutation)
        XCTAssertNil(info.firstname)
        XCTAssertNil(info.middlename)
        XCTAssertNil(info.lastname)
        XCTAssertNil(info.suffix)
        XCTAssertNil(info.payer)
        
        XCTAssertEqual(info.email.value, "email@example.com")
        XCTAssertEqual(info.birthdate, self.birthdate)
        XCTAssertEqual(info.tax.value, "85323EC0-A9114")
        XCTAssertEqual(info.taxType, .cpf)
        XCTAssertEqual(info.country, .unitedStates)
        XCTAssertEqual(info.billing, Address(
            recipientName: nil, defaultAddress: nil, line1: "Plum Fairy Ln.", line2: nil, city: "Ginger Planes", state: .le,
            country: .wallisAndFutuna, postalCode: "3552", phone: nil, type: nil
        ))
    }
    
    func testValidations()throws {
        var info = try Order.Payer.Info(
            email: .init("email@example.com"),
            birthdate: self.birthdate,
            tax: .init("85323EC0-A9114"),
            taxType: .cpf,
            country: .unitedStates,
            billing: Address(
                recipientName: nil, defaultAddress: nil, line1: "Plum Fairy Ln.", line2: nil, city: "Ginger Planes", state: .le,
                country: .wallisAndFutuna, postalCode: "3552", phone: nil, type: nil
            )
        )
        
        try XCTAssertThrowsError(info.email <~ String(repeating: "e", count: 128))
        try XCTAssertThrowsError(info.tax <~ String(repeating: "t", count: 15))
        try info.email <~ String(repeating: "e", count: 127)
        try info.tax <~ String(repeating: "t", count: 14)
        
        
        XCTAssertEqual(info.email.value, String(repeating: "e", count: 127))
        XCTAssertEqual(info.tax.value, String(repeating: "t", count: 14))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let info = try Order.Payer.Info(
            email: .init("email@example.com"),
            birthdate: Date(timeIntervalSince1970: 1_536_447_600),
            tax: .init("85323EC0-A9114"),
            taxType: .cpf,
            country: .unitedStates,
            billing: Address(
                recipientName: nil, defaultAddress: nil, line1: "Plum Fairy Ln.", line2: nil, city: "Ginger Planes", state: .le,
                country: .wallisAndFutuna, postalCode: "3552", phone: nil, type: nil
            )
        )
        let generated = try String(data: encoder.encode(info), encoding: .utf8)!
        let json =
        "{\"email\":\"email@example.com\",\"tax_id\":\"85323EC0-A9114\",\"country_code\":\"US\",\"birth_date\":\"2018-09-08\",\"billing_address\":{\"country_code\":\"WF\",\"state\":\"LE\",\"line1\":\"Plum Fairy Ln.\",\"city\":\"Ginger Planes\",\"postal_code\":\"3552\"},\"tax_id_type\":\"BR_CPF\"}"
        
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
                "state": "LE"
            },
            "country_code": "US",
            "tax_id_type": "BR_CPF",
            "tax_id": "85323EC0-A9114",
            "birth_date": "2018-09-08",
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
        XCTAssertEqual(info.tax.value, "85323EC0-A9114")
        XCTAssertEqual(info.birthdate, Date(timeIntervalSince1970: 1_536_364_800))
        XCTAssertEqual(info.email.value, "email@example.com")
        XCTAssertEqual(info.billing, Address(
            recipientName: nil, defaultAddress: nil, line1: "Plum Fairy Ln.", line2: nil, city: "Ginger Planes", state: .le,
            country: .wallisAndFutuna, postalCode: "3552", phone: nil, type: nil
        ))
    }
    
    static var allTests: [(String, (OrderPayerInfoTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
