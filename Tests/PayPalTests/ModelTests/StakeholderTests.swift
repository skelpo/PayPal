import XCTest
@testable import PayPal

final class StakeholderTests: XCTestCase {
    func testInit()throws {
        let holder = try Business.Stakeholder(
            type: .partner,
            country: "US",
            birth: TimelessDate(date: "2000-06-18"),
            name: Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "auth.", full: "Sir Walter Scott"),
            addresses: [],
            phones: [],
            ids: [],
            birthplace: BirthPlace(country: "US", city: "Boston")
        )
        
        XCTAssertNil(holder.ownership)
        XCTAssertEqual(holder.type, .partner)
        XCTAssertEqual(holder.country, "US")
        XCTAssertEqual(holder.addresses, [])
        XCTAssertEqual(holder.phones, [])
        XCTAssertEqual(holder.ids, [])
        try XCTAssertEqual(holder.birth, TimelessDate(date: "2000-06-18"))
        try XCTAssertEqual(holder.birthplace, BirthPlace(country: "US", city: "Boston"))
        try XCTAssertEqual(holder.name, Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "auth.", full: "Sir Walter Scott"))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Business.Stakeholder(type: nil, country: "USA", birth: nil, name: nil, addresses: [], phones: [], ids: [], birthplace: nil))
        var holder = try Business.Stakeholder(type: nil, country: "US", birth: nil, name: nil, addresses: [], phones: [], ids: [], birthplace: nil)
        
        try XCTAssertThrowsError(holder.set(\.country <~ "Aus."))
        try holder.set(\.country <~ "AU")
        
        XCTAssertEqual(holder.country, "AU")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let holder = try Business.Stakeholder(
            type: .partner,
            country: "US",
            birth: TimelessDate(date: "2000-06-18"),
            name: Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil),
            addresses: [],
            phones: [],
            ids: [],
            birthplace: BirthPlace(country: "US", city: "Boston")
        )
        let generated = try String(data: encoder.encode(holder), encoding: .utf8)!
        let json =
            "{\"place_of_birth\":{\"country_code\":\"US\",\"city\":\"Boston\"},\"identifications\":[],\"phones\":[],\"addresses\":[],\"name\":{}," +
            "\"date_of_birth\":{\"date_no_time\":\"2000-06-18\"},\"country_code_of_nationality\":\"US\",\"type\":\"PARTNER\"}"
        
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
            "place_of_birth": {
                "country_code": "US",
                "city": "Boston"
            },
            "identifications": [],
            "phones": [],
            "addresses": [],
            "name": {},
            "date_of_birth": {
                "date_no_time": "2000-06-18"
            },
            "country_code_of_nationality": "US",
            "type": "PARTNER"
        }
        """.data(using: .utf8)!
        let holder = try Business.Stakeholder(
            type: .partner,
            country: "US",
            birth: TimelessDate(date: "2000-06-18"),
            name: Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil),
            addresses: [],
            phones: [],
            ids: [],
            birthplace: BirthPlace(country: "US", city: "Boston")
        )
        
        try XCTAssertEqual(holder, decoder.decode(Business.Stakeholder.self, from: json))
    }
    
    static var allTests: [(String, (StakeholderTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


