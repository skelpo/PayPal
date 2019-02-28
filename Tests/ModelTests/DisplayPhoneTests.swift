import XCTest
@testable import PayPal

public final class DisplayPhoneTests: XCTestCase {
    func testInit()throws {
        let phone = DisplayPhone(country: .unitedStates, number: "245364984688834")
        
        XCTAssertEqual(phone.country, .unitedStates)
        XCTAssertEqual(phone.number, "245364984688834")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let phone = DisplayPhone(country: .unitedStates, number: "245364984688834")
        let generated = try String(data: encoder.encode(phone), encoding: .utf8)!
        let json = "{\"country_code\":\"US\",\"number\":\"245364984688834\"}"
        
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
            "country_code": "US",
            "number": "245364984688834"
        }
        """.data(using: .utf8)!
        let country = """
        {
            "country_code": "usa",
            "number": "245364984688834"
        }
        """
        
        try XCTAssertThrowsError(decoder.decode(DisplayPhone.self, from: country))
        try XCTAssertEqual(decoder.decode(DisplayPhone.self, from: json), DisplayPhone(country: .unitedStates, number: "245364984688834"))
    }
    
    static var allTests: [(String, (DisplayPhoneTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




