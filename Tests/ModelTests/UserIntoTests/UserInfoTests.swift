import XCTest
@testable import PayPal

public final class UserInfoTests: XCTestCase {
    func testDecoding()throws {
        let json = """
        {
            "user_id": "P-54D1D577D19D4C75",
            "name": "Arthur Conan Doyle, MD.",
            "given_name": "Arthur",
            "family_name": "Doyle",
            "middle_name": "Conan",
            "picture": "https://upload.wikimedia.org/wikipedia/commons/d/dd/Arthur_Conany_Doyle_by_Walter_Benington%2C_1914.png",
            "email": "sherlock@exmaple.com",
            "email_verified": true,
            "gender": "male",
            "birthdate": "1859-05-22",
            "zoneinfo": "GMT",
            "locale": "England",
            "address": {
                "locality": "Edinburgh",
                "postal_code": "1058",
                "country": "GB"
            },
            "verified_account": true,
            "account_type": "PERSONAL",
            "age_range": "100-200",
            "payer_id": "P-BCFC8B5AD16874F7"
        }
        """.data(using: .utf8)!
        
        let info = try JSONDecoder().decode(UserInfo.self, from: json)
        
        XCTAssertEqual(info.id, "P-54D1D577D19D4C75")
        XCTAssertEqual(info.name, "Arthur Conan Doyle, MD.")
        XCTAssertEqual(info.givenName, "Arthur")
        XCTAssertEqual(info.familyName, "Doyle")
        XCTAssertEqual(info.middleName, "Conan")
        XCTAssertEqual(info.picture, "https://upload.wikimedia.org/wikipedia/commons/d/dd/Arthur_Conany_Doyle_by_Walter_Benington%2C_1914.png")
        XCTAssertEqual(info.email, "sherlock@exmaple.com")
        XCTAssertEqual(info.emailVerified, true)
        XCTAssertEqual(info.gender, "male")
        XCTAssertEqual(info.birthdate, "1859-05-22")
        XCTAssertEqual(info.zoneinfo, "GMT")
        XCTAssertEqual(info.locale, "England")
        
        XCTAssertEqual(info.address?.locality, "Edinburgh")
        XCTAssertEqual(info.address?.zip, "1058")
        XCTAssertEqual(info.address?.country, .unitedKingdom)
        
        XCTAssertEqual(info.verified, true)
        XCTAssertEqual(info.accountType, .personal)
        XCTAssertEqual(info.ageRange, "100-200")
        XCTAssertEqual(info.payerID, "P-BCFC8B5AD16874F7")
    }
    
    static var allTests: [(String, (UserInfoTests) -> ()throws -> ())] = [
        ("testDecoding", testDecoding)
    ]
}


