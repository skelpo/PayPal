import XCTest
@testable import PayPal

public final class LegalAgreementTests: XCTestCase {
    func testInit()throws {
        let agreement = LegalAgreement(accepted: false, type: .userAgreement)
        
        XCTAssertEqual(agreement.accepted, false)
        XCTAssertEqual(agreement.type, .userAgreement)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let agreement = try String(data: encoder.encode(LegalAgreement(accepted: false, type: .userAgreement)), encoding: .utf8)
        
        XCTAssertEqual(agreement, "{\"type\":\"USER_AGREEMENT\",\"accepted\":false}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let mit = """
        {
            "accepted": false,
            "type": "USER_AGREEMENT"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(
            LegalAgreement(accepted: false, type: .userAgreement),
            decoder.decode(LegalAgreement.self, from: mit)
        )
    }
    
    public static var allTests: [(String, (LegalAgreementTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

