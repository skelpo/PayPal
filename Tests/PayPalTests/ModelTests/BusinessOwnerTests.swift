import XCTest
@testable import PayPal

final class BusinessOwnerTests: XCTestCase {
    func testInit()throws {
        let owner = try BusinessOwner(
            email: "business@example.com",
            name: Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "Bart.", full: "Sir Walter Scott"),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: "1771-08-15",
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        )
        
        XCTAssertEqual(owner.email, "business@example.com")
        XCTAssertEqual(owner.relationships, [])
        XCTAssertEqual(owner.country, .unitedKingdom)
        XCTAssertEqual(owner.addresses, [])
        XCTAssertEqual(owner.birthdate, "1771-08-15")
        XCTAssertEqual(owner.language, .en_GB)
        XCTAssertEqual(owner.phones, [])
        XCTAssertEqual(owner.ids, [])
        XCTAssertEqual(owner.occupation, "Author")
        try XCTAssertEqual(owner.name, Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "Bart.", full: "Sir Walter Scott"))
    }
    
    func testValueValidation()throws {
        try XCTAssertThrowsError(BusinessOwner(
            email: "business@",
            name: Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "Bart.", full: "Sir Walter Scott"),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: "1771-08-15",
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        ))
        try XCTAssertThrowsError(BusinessOwner(
            email: "business@example.com",
            name: Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "Bart.", full: "Sir Walter Scott"),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: "08/15/1771",
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        ))
        var owner = try BusinessOwner(
            email: "business@example.com",
            name: Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "Bart.", full: "Sir Walter Scott"),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: "1771-08-15",
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        )
        
        try XCTAssertThrowsError(owner.set(\.email <~ "scottinklings.swift"))
        try XCTAssertThrowsError(owner.set(\.birthdate <~ "05/06/1969"))
        try owner.set(\.email <~ "scott@inklings.swift")
        try owner.set(\.birthdate <~ "1969-06-05")
        
        XCTAssertEqual(owner.email, "scott@inklings.swift")
        XCTAssertEqual(owner.birthdate, "1969-06-05")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let owner = try BusinessOwner(
            email: "business@example.com",
            name: Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "Bart.", full: "Sir Walter Scott"),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: "1771-08-15",
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        )
        let generated = try String(data: encoder.encode(owner), encoding: .utf8)!
        let json =
            "{\"phones\":[],\"account_owner_relationships\":[],\"country_code_of_nationality\":\"GB\",\"date_of_birth\":\"1771-08-15\"," +
            "\"addresses\":[],\"email\":\"business@example.com\",\"occupation\":\"Author\",\"identifications\":[]," +
            "\"name\":{\"given_name\":\"Walter\",\"full_name\":\"Sir Walter Scott\",\"prefix\":\"Sir\",\"surname\":\"Scott\"," +
            "\"suffix\":\"Bart.\"},\"language_code\":\"en_GB\"}"
        
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
        
        let owner = try BusinessOwner(
            email: "business@example.com",
            name: Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "Bart.", full: "Sir Walter Scott"),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: "1771-08-15",
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        )
        let json = """
        {
            "occupation": "Author",
            "identifications": [],
            "phones": [],
            "language_code": "en_GB",
            "date_of_birth": "1771-08-15",
            "addresses": [],
            "country_code_of_nationality": "GB",
            "account_owner_relationships": [],
            "name": {
                "full_name": "Sir Walter Scott",
                "suffix": "Bart.",
                "surname": "Scott",
                "given_name": "Walter",
                "prefix": "Sir"
            },
            "email": "business@example.com"
        }
        """.data(using: .utf8)!
        let email = """
        {
            "occupation": "Author",
            "identifications": [],
            "phones": [],
            "language_code": "en_GB",
            "date_of_birth": "1771-08-15",
            "addresses": [],
            "country_code_of_nationality": "UK",
            "account_owner_relationships": [],
            "name": {
                "full_name": "Sir Walter Scott",
                "suffix": "Bart.",
                "surname": "Scott",
                "given_name": "Walter",
                "prefix": "Sir"
            },
            "email": "business@"
        }
        """.data(using: .utf8)!
        let country = """
        {
            "occupation": "Author",
            "identifications": [],
            "phones": [],
            "language_code": "en_GB",
            "date_of_birth": "1771-08-15",
            "addresses": [],
            "country_code_of_nationality": "usa",
            "account_owner_relationships": [],
            "name": {
                "full_name": "Sir Walter Scott",
                "suffix": "Bart.",
                "surname": "Scott",
                "given_name": "Walter",
                "prefix": "Sir"
            },
            "email": "business@example.com"
        }
        """.data(using: .utf8)!
        let birthdate = """
        {
            "occupation": "Author",
            "identifications": [],
            "phones": [],
            "language_code": "en_GB",
            "date_of_birth": "08/15/1771",
            "addresses": [],
            "country_code_of_nationality": "usa",
            "account_owner_relationships": [],
            "name": {
                "full_name": "Sir Walter Scott",
                "suffix": "Bart.",
                "surname": "Scott",
                "given_name": "Walter",
                "prefix": "Sir"
            },
            "email": "business@example.com"
        }
        """.data(using: .utf8)!
        
        
        try XCTAssertEqual(owner, decoder.decode(BusinessOwner.self, from: json))
        try XCTAssertThrowsError(decoder.decode(BusinessOwner.self, from: email))
        try XCTAssertThrowsError(decoder.decode(BusinessOwner.self, from: country))
        try XCTAssertThrowsError(decoder.decode(BusinessOwner.self, from: birthdate))
    }
    
    static var allTests: [(String, (BusinessOwnerTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




