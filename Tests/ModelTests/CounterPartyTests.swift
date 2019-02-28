import XCTest
@testable import PayPal

public final class CounterPartyTests: XCTestCase {
    func testInit()throws {
        let party = CounterParty(email: "54north@exmaple.com", phoneNumber: "314-159-2653", name: "Jonathan Futher")
        
        XCTAssertEqual(party.email, "54north@exmaple.com")
        XCTAssertEqual(party.phoneNumber, "314-159-2653")
        XCTAssertEqual(party.name, "Jonathan Futher")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let license = try String(data: encoder.encode(
            CounterParty(email: "54north@exmaple.com", phoneNumber: "314-159-2653", name: "Jonathan Futher")
        ), encoding: .utf8)
        
        XCTAssertEqual(license, "{\"email\":\"54north@exmaple.com\",\"name\":\"Jonathan Futher\",\"phone_number\":\"314-159-2653\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let valid = """
        {
            "name": "Jonathan Futher",
            "email": "54north@exmaple.com",
            "phone_number": "314-159-2653"
        }
        """.data(using: .utf8)!
        let keyFail = """
        {
            "name": "Jonathan Futher",
            "email": "54north@exmaple.com",
            "phoneNumber": "314-159-2653"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(
            CounterParty(email: "54north@exmaple.com", phoneNumber: nil, name: "Jonathan Futher"),
            decoder.decode(CounterParty.self, from: keyFail)
        )
        try XCTAssertEqual(
            CounterParty(email: "54north@exmaple.com", phoneNumber: "314-159-2653", name: "Jonathan Futher"),
            decoder.decode(CounterParty.self, from: valid)
        )
    }
    
    static var allTests: [(String, (CounterPartyTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
