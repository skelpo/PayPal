import XCTest
import Failable
@testable import PayPal

final class SellerTests: XCTestCase {
    func testInit()throws {
        let seller = try Seller(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather", merchantID: nil)
        
        XCTAssertNil(seller.merchantID)
        XCTAssertEqual(seller.email.value, "witheringheights@exmaple.com")
        XCTAssertEqual(seller.name, "Leeli Wingfeather")
    }
    
    func testValidations()throws {
        var seller = try Seller(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather", merchantID: nil)
        
        try XCTAssertThrowsError(seller.email <~ "upsidedown")
        try seller.email <~ "lizard.kicker@glipwood.com"
        
        XCTAssertEqual(seller.email.value, "lizard.kicker@glipwood.com")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(
            data: encoder.encode(Seller(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather", merchantID: nil)),
            encoding: .utf8
        )
        
        XCTAssertEqual(generated, "{\"email\":\"witheringheights@exmaple.com\",\"name\":\"Leeli Wingfeather\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "merchant_id": "456261F7-20E2-46F8-8BFD-EEF0C911D76D",
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
        try XCTAssertEqual(
            Seller(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather", merchantID: "456261F7-20E2-46F8-8BFD-EEF0C911D76D"),
            decoder.decode(Seller.self, from: json)
        )
    }
    
    static var allTests: [(String, (SellerTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



