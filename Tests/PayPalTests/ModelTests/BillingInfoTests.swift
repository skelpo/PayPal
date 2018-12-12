import XCTest
@testable import PayPal

final class BillingInfoTests: XCTestCase {
    func testInit()throws {
        let info = try BillingInfo(
            email: .init("ratigan@thirdceller.com"),
            phone: PhoneNumber(country: .init(1), number: .init(4586901518)),
            firstName: .init("Padraic"),
            lastName: .init("Ratigan"),
            businessName: .init("Crime Lord"),
            address: Address(
                recipientName: nil,
                defaultAddress: true,
                line1: "3rd Celler, Baker Street",
                line2: nil,
                city: "London",
                state: nil,
                country: .unitedKingdom,
                postalCode: "42",
                phone: nil,
                type: nil
            ),
            language: .en_GB,
            info: .init("For the captain.")
        )

        XCTAssertEqual(info.email.value, "ratigan@thirdceller.com")
        XCTAssertEqual(info.firstName.value, "Padraic")
        XCTAssertEqual(info.lastName.value, "Ratigan")
        XCTAssertEqual(info.businessName.value, "Crime Lord")
        XCTAssertEqual(info.language, .en_GB)
        XCTAssertEqual(info.info.value, "For the captain.")
        
        try XCTAssertEqual(info.phone, PhoneNumber(country: .init(1), number: .init(4586901518)))
        XCTAssertEqual(info.address, Address(
            recipientName: nil,
            defaultAddress: true,
            line1: "3rd Celler, Baker Street",
            line2: nil,
            city: "London",
            state: nil,
            country: .unitedKingdom,
            postalCode: "42",
            phone: nil,
            type: nil
        ))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(BillingInfo(
            email: .init("\(String(repeating: "e", count: 260))@thirdceller.com"),
            phone: nil,
            firstName: .init("Padraic"),
            lastName: .init("Ratigan"),
            businessName: .init("Crime Lord"),
            address: nil,
            language: .en_GB,
            info: .init("For the captain.")
        ))
        try XCTAssertThrowsError(BillingInfo(
            email: .init("ratigan@thirdceller.com"),
            phone: nil,
            firstName: .init(String(repeating: "f", count: 31)),
            lastName: .init("Ratigan"),
            businessName: .init("Crime Lord"),
            address: nil,
            language: .en_GB,
            info: .init("For the captain.")
        ))
        try XCTAssertThrowsError(BillingInfo(
            email: .init("ratigan@thirdceller.com"),
            phone: nil,
            firstName: .init("Padraic"),
            lastName: .init(String(repeating: "f", count: 31)),
            businessName: .init("Crime Lord"),
            address: nil,
            language: .en_GB,
            info: .init("For the captain.")
        ))
        try XCTAssertThrowsError(BillingInfo(
            email: .init("ratigan@thirdceller.com"),
            phone: nil,
            firstName: .init("Padraic"),
            lastName: .init("Ratigan"),
            businessName: .init(String(repeating: "b", count: 101)),
            address: nil,
            language: .en_GB,
            info: .init("For the captain.")
        ))
        try XCTAssertThrowsError(BillingInfo(
            email: .init("ratigan@thirdceller.com"),
            phone: nil,
            firstName: .init("Padraic"),
            lastName: .init("Ratigan"),
            businessName: .init("Crime Lord"),
            address: nil,
            language: .en_GB,
            info: .init(String(repeating: "i", count: 41))
        ))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let info = try BillingInfo(
            email: .init("ratigan@thirdceller.com"),
            phone: PhoneNumber(country: .init(1), number: .init(4586901518)),
            firstName: .init("Padraic"),
            lastName: .init("Ratigan"),
            businessName: .init("Crime Lord"),
            address: nil,
            language: .en_GB,
            info: .init("For the captain.")
        )
        let generated = try String(data: encoder.encode(info), encoding: .utf8)!
        let json =
            "{\"phone\":{\"country_code\":\"1\",\"national_number\":\"4586901518\"},\"business_name\":\"Crime Lord\",\"last_name\":\"Ratigan\"," +
            "\"email\":\"ratigan@thirdceller.com\",\"language\":\"en_GB\",\"additional_info\":\"For the captain.\",\"first_name\":\"Padraic\"}"
        
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
            "additional_info": "For the captain.",
            "language": "en_GB",
            "business_name": "Crime Lord",
            "last_name": "Ratigan",
            "first_name": "Padraic",
            "phone": {
                "country_code": "1",
                "national_number": "4586901518"
            },
            "email": "ratigan@thirdceller.com"
        }
        """.data(using: .utf8)!
        let emailFail = """
        {
            "additional_info": "\(String(repeating: "e", count: 260))@thirdceller.com",
            "language": "en_GB",
            "business_name": "Crime Lord",
            "last_name": "Ratigan",
            "first_name": "Padraic",
            "phone": {
                "country_code": "1",
                "national_number": "4586901518"
            },
            "email": "ratigan@thirdceller.com"
        }
        """.data(using: .utf8)!
        let firstnameFail = """
        {
            "additional_info": "For the captain.",
            "language": "en_GB",
            "business_name": "Crime Lord",
            "last_name": "Ratigan",
            "first_name": "\(String(repeating: "f", count: 31))",
            "phone": {
                "country_code": "1",
                "national_number": "4586901518"
            },
            "email": "ratigan@thirdceller.com"
        }
        """.data(using: .utf8)!
        let lastnameFail = """
        {
            "additional_info": "For the captain.",
            "language": "en_GB",
            "business_name": "Crime Lord",
            "last_name": "\(String(repeating: "f", count: 31))",
            "first_name": "Padraic",
            "phone": {
                "country_code": "1",
                "national_number": "4586901518"
            },
            "email": "ratigan@thirdceller.com"
        }
        """.data(using: .utf8)!
        let businessFail = """
        {
            "additional_info": "For the captain.",
            "language": "en_GB",
            "business_name": "\(String(repeating: "b", count: 101))",
            "last_name": "Ratigan",
            "first_name": "Padraic",
            "phone": {
                "country_code": "1",
                "national_number": "4586901518"
            },
            "email": "ratigan@thirdceller.com"
        }
        """.data(using: .utf8)!
        let infoFail = """
        {
            "additional_info": "\(String(repeating: "i", count: 41))",
            "language": "en_GB",
            "business_name": "Crime Lord",
            "last_name": "Ratigan",
            "first_name": "Padraic",
            "phone": {
                "country_code": "1",
                "national_number": "4586901518"
            },
            "email": "ratigan@thirdceller.com"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(BillingInfo.self, from: emailFail))
        try XCTAssertThrowsError(decoder.decode(BillingInfo.self, from: firstnameFail))
        try XCTAssertThrowsError(decoder.decode(BillingInfo.self, from: lastnameFail))
        try XCTAssertThrowsError(decoder.decode(BillingInfo.self, from: businessFail))
        try XCTAssertThrowsError(decoder.decode(BillingInfo.self, from: infoFail))
        
        let info = try decoder.decode(BillingInfo.self, from: json)
        XCTAssertEqual(info.email.value, "ratigan@thirdceller.com")
        XCTAssertEqual(info.firstName.value, "Padraic")
        XCTAssertEqual(info.lastName.value, "Ratigan")
        XCTAssertEqual(info.businessName.value, "Crime Lord")
        XCTAssertEqual(info.language, .en_GB)
        XCTAssertEqual(info.info.value, "For the captain.")
        try XCTAssertEqual(info.phone, PhoneNumber(country: .init(1), number: .init(4586901518)))
    }
    
    static var allTests: [(String, (BillingInfoTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



