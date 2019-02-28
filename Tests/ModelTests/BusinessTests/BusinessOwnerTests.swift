import XCTest
import Failable
@testable import PayPal

public final class BusinessOwnerTests: XCTestCase {
    let (date, dateStr): (Date, String) = {
        let now = Date()
        let str = TimelessDate.formatter.string(from: now)
        let date = TimelessDate.formatter.date(from: str)!
        
        return (date, str)
    }()
    
    func testInit()throws {
        let owner = try BusinessOwner(
            email: .init("business@example.com"),
            name: Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: self.date,
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        )
        
        XCTAssertEqual(owner.email.value, "business@example.com")
        XCTAssertEqual(owner.relationships, [])
        XCTAssertEqual(owner.country, .unitedKingdom)
        XCTAssertEqual(owner.addresses, [])
        XCTAssertEqual(owner.birthdate, self.date)
        XCTAssertEqual(owner.language, .en_GB)
        XCTAssertEqual(owner.phones, [])
        XCTAssertEqual(owner.ids, [])
        XCTAssertEqual(owner.occupation, "Author")
        XCTAssertEqual(owner.name, Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil))
    }
    
    func testValueValidation()throws {
        var owner = try BusinessOwner(
            email: .init("business@example.com"),
            name: Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: self.date,
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        )
        
        try XCTAssertThrowsError(owner.email <~ "scottinklings.swift")
        try owner.email <~ "scott@inklings.swift"
        
        XCTAssertEqual(owner.email.value, "scott@inklings.swift")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let owner = try BusinessOwner(
            email: .init("business@example.com"),
            name: Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: self.date,
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        )
        let generated = try String(data: encoder.encode(owner), encoding: .utf8)!
        let json =
            "{\"phones\":[],\"country_code_of_nationality\":\"GB\",\"date_of_birth\":\"\(dateStr)\",\"account_owner_relationships\":[]," +
            "\"addresses\":[],\"email\":\"business@example.com\",\"identifications\":[],\"occupation\":\"Author\"," +
            "\"name\":{},\"language_code\":\"en_GB\"}"
        
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
            email: .init("business@example.com"),
            name: Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: self.date,
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
            "date_of_birth": "\(self.dateStr)",
            "addresses": [],
            "country_code_of_nationality": "GB",
            "account_owner_relationships": [],
            "name": {},
            "email": "business@example.com"
        }
        """.data(using: .utf8)!
        let email = """
        {
            "occupation": "Author",
            "identifications": [],
            "phones": [],
            "language_code": "en_GB",
            "date_of_birth": "\(self.dateStr)",
            "addresses": [],
            "country_code_of_nationality": "UK",
            "account_owner_relationships": [],
            "name": {},
            "email": "business@"
        }
        """.data(using: .utf8)!
        let country = """
        {
            "occupation": "Author",
            "identifications": [],
            "phones": [],
            "language_code": "en_GB",
            "date_of_birth": "\(self.dateStr)",
            "addresses": [],
            "country_code_of_nationality": "usa",
            "account_owner_relationships": [],
            "name": {},
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
            "name": {},
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




