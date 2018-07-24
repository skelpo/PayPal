import XCTest
@testable import PayPal

final class BuyerTests: XCTestCase {
    func testInit()throws {
        let buyer = try Buyer(email: "witheringheights@exmaple.com", name: "Leeli Wingfeather")
        
        XCTAssertEqual(buyer.email, "witheringheights@exmaple.com")
        XCTAssertEqual(buyer.name, "Leeli Wingfeather")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Buyer(email: "downsideup", name: "Leeli Wingfeather"))
        var buyer = try Buyer(email: "witheringheights@exmaple.com", name: "Leeli Wingfeather")
        
        try XCTAssertThrowsError(buyer.set(\.email <~ "upsidedown"))
        try buyer.set(\.email <~ "lizard.kicker@glipwood.com")
        
        XCTAssertEqual(buyer.email, "lizard.kicker@glipwood.com")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(Buyer(email: "witheringheights@exmaple.com", name: "Leeli Wingfeather")), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"email\":\"witheringheights@exmaple.com\",\"name\":\"Leeli Wingfeather\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "name": "Leeli Wingfeather",
            "email": "witheringheights@exmaple.com"
        }
        """.data(using: .utf8)!
        let invalid = """
        {
            "name": "Leeli Wingfeather",
            "email": "downsideup"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(Buyer.self, from: invalid))
        try XCTAssertEqual(Buyer(email: "witheringheights@exmaple.com", name: "Leeli Wingfeather"), decoder.decode(Buyer.self, from: json))
    }
    
    static var allTests: [(String, (BuyerTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


