import XCTest
@testable import PayPal

final class EstablishmentTests: XCTestCase {
    func testInit()throws {
        let bank = try Establishment(state: "OR", country: "US")
        
        XCTAssertEqual(bank.state, "OR")
        XCTAssertEqual(bank.country, "US")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Establishment(state: "OR", country: "usa"))
        var bank = try Establishment(state: "OR", country: "US")
        
        try XCTAssertThrowsError(bank.set(\.country <~ "usa"))
        try bank.set(\.country <~ "GB")
        
        XCTAssertEqual(bank.country, "GB")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let bank = try Establishment(state: "OR", country: "US")
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
        try XCTAssertEqual(decoder.decode(Establishment.self, from: json), Establishment(state: "OR", country: "US"))
    }
    
    static var allTests: [(String, (EstablishmentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



