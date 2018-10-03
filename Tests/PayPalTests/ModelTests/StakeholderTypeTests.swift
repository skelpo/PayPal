import XCTest
@testable import PayPal

typealias StakeholderType = Business.Stakeholder.StakeholderType

final class StakeholderTypeTests: XCTestCase {
    struct Holder: Codable {
        let type: Business.Stakeholder.StakeholderType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(StakeholderType.chairman.rawValue, "CHAIRMAN")
        XCTAssertEqual(StakeholderType.partner.rawValue, "PARTNER")
        XCTAssertEqual(StakeholderType.partnerBusiness.rawValue, "PARTNER_BUSINESS")
        XCTAssertEqual(StakeholderType.secretary.rawValue, "SECRETARY")
        XCTAssertEqual(StakeholderType.treasurer.rawValue, "TREASURER")
        XCTAssertEqual(StakeholderType.director.rawValue, "DIRECTOR")
        XCTAssertEqual(StakeholderType.beneficialOwner.rawValue, "BENEFICIAL_OWNER")
        XCTAssertEqual(StakeholderType.beneficialOwnerBusiness.rawValue, "BENEFICIAL_OWNER_BUSINESS")
    }
    
    func testAllCase() {
        XCTAssertEqual(StakeholderType.allCases.count, 8)
        XCTAssertEqual(StakeholderType.allCases, [
            .chairman, .partner, .partnerBusiness, .secretary, .treasurer, .director, .beneficialOwner, .beneficialOwnerBusiness
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let partner = try String(data: encoder.encode(Holder(type: .partner)), encoding: .utf8)
        let partnerBusiness = try String(data: encoder.encode(Holder(type: .partnerBusiness)), encoding: .utf8)
        
        XCTAssertEqual(partner, "{\"type\":\"PARTNER\"}")
        XCTAssertEqual(partnerBusiness, "{\"type\":\"PARTNER_BUSINESS\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let beneficialOwner = """
        {
            "type": "BENEFICIAL_OWNER"
        }
        """.data(using: .utf8)!
        let beneficialOwnerBusiness = """
        {
            "type": "BENEFICIAL_OWNER_BUSINESS"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Holder.self, from: beneficialOwner).type, .beneficialOwner)
        try XCTAssertEqual(decoder.decode(Holder.self, from: beneficialOwnerBusiness).type, .beneficialOwnerBusiness)
    }
    
    static var allTests: [(String, (StakeholderTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



