import XCTest
@testable import PayPal

public final class UserInfoAddressTests: XCTestCase {
    func testDecoding()throws {
        let json = """
        {
            "street_address": "Igby Cottage, Dark Sea of Darkness",
            "locality": "Glipwood",
            "postal_code": "1058",
            "country": "CH"
        }
        """.data(using: .utf8)!
        
        let address = try JSONDecoder().decode(UserInfo.Address.self, from: json)
        
        XCTAssertEqual(address.streetAddress, "Igby Cottage, Dark Sea of Darkness")
        XCTAssertEqual(address.locality, "Glipwood")
        XCTAssertEqual(address.region, nil)
        XCTAssertEqual(address.zip, "1058")
        XCTAssertEqual(address.country, .switzerland)
    }
    
    public static var allTests: [(String, (UserInfoAddressTests) -> ()throws -> ())] = [
        ("testDecoding", testDecoding)
    ]
}




