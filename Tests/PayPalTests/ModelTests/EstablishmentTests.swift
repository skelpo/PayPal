import XCTest
@testable import PayPal

final class EstablishmentTests: XCTestCase {
    func testInit()throws {
        let bank = Establishment(state: .or, country: .unitedStates)
        
        XCTAssertEqual(bank.state, .or)
        XCTAssertEqual(bank.country, .unitedStates)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let bank = Establishment(state: .or, country: .unitedStates)
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
        try XCTAssertEqual(decoder.decode(Establishment.self, from: json), Establishment(state: .or, country: .unitedStates))
    }
    
    static var allTests: [(String, (EstablishmentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



