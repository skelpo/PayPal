import XCTest
import Failable
@testable import PayPal

public final class BuyerTests: XCTestCase {
    func testInit()throws {
        let buyer = try Buyer(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather")
        
        XCTAssertEqual(buyer.email.value, "witheringheights@exmaple.com")
        XCTAssertEqual(buyer.name, "Leeli Wingfeather")
    }
    
    func testValidations()throws {
        var buyer = try Buyer(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather")
        
        try XCTAssertThrowsError(buyer.email <~ "upsidedown")
        try buyer.email <~ "lizard.kicker@glipwood.com"
        
        XCTAssertEqual(buyer.email.value, "lizard.kicker@glipwood.com")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(Buyer(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather")), encoding: .utf8)
        
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
        try XCTAssertEqual(Buyer(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather"), decoder.decode(Buyer.self, from: json))
    }
    
    static var allTests: [(String, (BuyerTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


