import XCTest
@testable import PayPal

final class CreatedMerchantResponseTests: XCTestCase {
    func testDecoding()throws {
        let json = """
        {
            "payer_id": "12D54EFB-D12F-4AF8-B5BF-AC62FFE253CC",
            "partner_merchant_external_id": "DA1F6BA7-9D8B-4D78-BFB4-A74F9AF83674",
            "merchant_authorization_code": "6C0AB2D4-5668-42E6-B943-9FF9956D860B",
            "custom_data": [],
            "errors": [],
            "links": []
        }
        """.data(using: .utf8)!
        
        let response = try JSONDecoder().decode(CreatedMerchantResponse.self, from: json)
        XCTAssertEqual(response.links, [])
        XCTAssertEqual(response.custom, [:])
        XCTAssertEqual(response.errors, [])
        XCTAssertEqual(response.payer, .init("12D54EFB-D12F-4AF8-B5BF-AC62FFE253CC"))
        try XCTAssertEqual(response.partnerExternalID, .init("DA1F6BA7-9D8B-4D78-BFB4-A74F9AF83674"))
        try XCTAssertEqual(response.authCode, .init("6C0AB2D4-5668-42E6-B943-9FF9956D860B"))
    }
    
    static var allTests: [(String, (CreatedMerchantResponseTests) -> ()throws -> ())] = [
        ("testDecoding", testDecoding)
    ]
}





