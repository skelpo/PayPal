import XCTest
@testable import PayPal

final class EstablishmentTests: XCTestCase {
    func testInit()throws {
        let bank = Establishment(state: "OR", country: .unitedStates)
        
        XCTAssertEqual(bank.state, "OR")
        XCTAssertEqual(bank.country, .unitedStates)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let bank = Establishment(state: "OR", country: .unitedStates)
        let generated = try String(data: encoder.encode(bank), encoding: .utf8)!
        
        XCTAssertEqual(generated, "{\"state\":\"OR\",\"country_code\":\"US\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "state": "OR",
            "country_code": "US"
        }
        """.data(using: .utf8)!
        let country = """
        {
            "state": "OR",
            "country_code": "usa"
        }
        """
        
        try XCTAssertThrowsError(decoder.decode(Establishment.self, from: country))
        try XCTAssertEqual(decoder.decode(Establishment.self, from: json), Establishment(state: "OR", country: .unitedStates))
    }
    
    static var allTests: [(String, (EstablishmentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



