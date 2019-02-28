import XCTest
@testable import PayPal

typealias AgreementType = LegalAgreement.AgreementType

public final class LegalAgreementTypeTests: XCTestCase {
    struct Agreement: Codable {
        let type: AgreementType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(AgreementType.userAgreement.rawValue, "USER_AGREEMENT")
        XCTAssertEqual(AgreementType.financialAuthority.rawValue, "FINANCIAL_BINDING_AUTHORITY")
    }
    
    func testAllCase() {
        XCTAssertEqual(AgreementType.allCases.count, 2)
        XCTAssertEqual(AgreementType.allCases, [.userAgreement, .financialAuthority])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let userAgreement = try String(data: encoder.encode(Agreement(type: .userAgreement)), encoding: .utf8)
        let financialAuthority = try String(data: encoder.encode(Agreement(type: .financialAuthority)), encoding: .utf8)
        
        XCTAssertEqual(userAgreement, "{\"type\":\"USER_AGREEMENT\"}")
        XCTAssertEqual(financialAuthority, "{\"type\":\"FINANCIAL_BINDING_AUTHORITY\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let userAgreement = """
        {
            "type": "USER_AGREEMENT"
        }
        """.data(using: .utf8)!
        let financialAuthority = """
        {
            "type": "FINANCIAL_BINDING_AUTHORITY"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Agreement.self, from: userAgreement).type, .userAgreement)
        try XCTAssertEqual(decoder.decode(Agreement.self, from: financialAuthority).type, .financialAuthority)
    }
    
    static var allTests: [(String, (LegalAgreementTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





