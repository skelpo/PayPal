import XCTest
@testable import PayPal

public final class CounterPartyTests: XCTestCase {
    func testInit()throws {
        let party = CounterParty(
            email: "54north@exmaple.com",
            phoneNumber: "314-159-2653",
            firstName: "Jonathan",
            lastName: "Further",
            name: "Jonathan Futher",
            payment: "8KK76419U6099791A"
        )
        
        XCTAssertEqual(party.email, "54north@exmaple.com")
        XCTAssertEqual(party.phoneNumber, "314-159-2653")
        XCTAssertEqual(party.firstName, "Jonathan")
        XCTAssertEqual(party.lastName, "Further")
        XCTAssertEqual(party.name, "Jonathan Futher")
        XCTAssertEqual(party.payment, "8KK76419U6099791A")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let party = CounterParty(
            email: "54north@exmaple.com",
            phoneNumber: "314-159-2653",
            firstName: "Jonathan",
            lastName: "Further",
            name: "Jonathan Futher",
            payment: "8KK76419U6099791A"
        )
        
        let license = try String(data: encoder.encode(party), encoding: .utf8)
        let json =
            "{\"email\":\"54north@exmaple.com\",\"payment_id\":\"8KK76419U6099791A\",\"last_name\":\"Further\"," +
            "\"name\":\"Jonathan Futher\",\"phone_number\":\"314-159-2653\",\"first_name\":\"Jonathan\"}"
        
        XCTAssertEqual(license, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "first_name": "Jonathan",
            "last_name": "Further",
            "name": "Jonathan Futher",
            "email": "54north@exmaple.com",
            "phone_number": "314-159-2653",
            "payment_id": "8KK76419U6099791A"
        }
        """.data(using: .utf8)!
        
        let party = CounterParty(
            email: "54north@exmaple.com",
            phoneNumber: "314-159-2653",
            firstName: "Jonathan",
            lastName: "Further",
            name: "Jonathan Futher",
            payment: "8KK76419U6099791A"
        )
        try XCTAssertEqual(party, decoder.decode(CounterParty.self, from: json))
    }
    
    public static var allTests: [(String, (CounterPartyTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
