import XCTest
@testable import PayPal

public final class StakeholderTests: XCTestCase {
    func testInit()throws {
        let holder = Business.Stakeholder(
            type: .partner,
            country: .unitedStates,
            birth: TimelessDate(date: "2000-06-18"),
            name: Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil),
            addresses: [],
            phones: [],
            ids: [],
            birthplace: BirthPlace(country: .unitedStates, city: "Boston")
        )
        
        XCTAssertNil(holder.ownership)
        XCTAssertEqual(holder.type, .partner)
        XCTAssertEqual(holder.country, .unitedStates)
        XCTAssertEqual(holder.addresses, [])
        XCTAssertEqual(holder.phones, [])
        XCTAssertEqual(holder.ids, [])
        XCTAssertEqual(holder.birth, TimelessDate(date: "2000-06-18"))
        XCTAssertEqual(holder.birthplace, BirthPlace(country: .unitedStates, city: "Boston"))
        XCTAssertEqual(holder.name, Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let holder = Business.Stakeholder(
            type: .partner,
            country: .unitedStates,
            birth: TimelessDate(date: "2000-06-18"),
            name: Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil),
            addresses: [],
            phones: [],
            ids: [],
            birthplace: BirthPlace(country: .unitedStates, city: "Boston")
        )
        let generated = try String(data: encoder.encode(holder), encoding: .utf8)!
        let json =
            "{\"phones\":[],\"country_code_of_nationality\":\"US\",\"date_of_birth\":{\"date_no_time\":\"2000-06-18\"},\"addresses\":[]," +
            "\"identifications\":[],\"type\":\"PARTNER\",\"name\":{},\"place_of_birth\":{\"country_code\":\"US\",\"city\":\"Boston\"}}"
        
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
        let holder = Business.Stakeholder(
            type: .partner,
            country: .unitedStates,
            birth: TimelessDate(date: "2000-06-18"),
            name: Name(prefix: nil, given: nil, surname: nil, middle: nil, suffix: nil, full: nil),
            addresses: [],
            phones: [],
            ids: [],
            birthplace: BirthPlace(country: .unitedStates, city: "Boston")
        )
        
        try XCTAssertEqual(holder, decoder.decode(Business.Stakeholder.self, from: json))
    }
    
    static var allTests: [(String, (StakeholderTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


