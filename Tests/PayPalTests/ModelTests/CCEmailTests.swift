import XCTest
@testable import PayPal

final class CCEmailTests: XCTestCase {
    func testInit()throws {
        let email = try Email<CCEmailKeys>(email: "witheringheights@exmaple.com")
        
        XCTAssertEqual(email.email, "witheringheights@exmaple.com")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Email<CCEmailKeys>(email: "witheringheightsexmaple.com"))
        try XCTAssertThrowsError(Email<CCEmailKeys>(email: "@exmaple.com"))
        try XCTAssertThrowsError(Email<CCEmailKeys>(email: "witheringheights@"))
        try XCTAssertThrowsError(Email<CCEmailKeys>(email: "witheringheights@-exmaple.com"))
        try XCTAssertThrowsError(Email<CCEmailKeys>(email: "w@"))
        try XCTAssertThrowsError(Email<CCEmailKeys>(email: String(repeating: "e", count: 255)))
        var email = try Email<CCEmailKeys>(email: "witheringheights@exmaple.com")
        
        try XCTAssertThrowsError(email.set(\.email <~ "witheringheights"))
        try email.set(\.email <~ "lizard.kicker@glipwood.net")
        
        XCTAssertEqual(email.email, "lizard.kicker@glipwood.net")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(Email<CCEmailKeys>(email: "witheringheights@exmaple.com")), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"cc_email\":\"witheringheights@exmaple.com\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "cc_email": "witheringheights@exmaple.com"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(Email<CCEmailKeys>(email: "witheringheights@exmaple.com"), decoder.decode(Email<CCEmailKeys>.self, from: json))
    }
    
    static var allTests: [(String, (CCEmailTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



