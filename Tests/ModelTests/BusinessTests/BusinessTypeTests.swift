import XCTest
@testable import PayPal

public final class BusinessTypeTests: XCTestCase {
    struct Busi: Codable {
        let type: Business.BusinessType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Business.BusinessType.individual.rawValue, "INDIVIDUAL")
        XCTAssertEqual(Business.BusinessType.proprietorship.rawValue, "PROPRIETORSHIP")
        XCTAssertEqual(Business.BusinessType.partnership.rawValue, "PARTNERSHIP")
        XCTAssertEqual(Business.BusinessType.corporation.rawValue, "CORPORATION")
        XCTAssertEqual(Business.BusinessType.nonprofit.rawValue, "NONPROFIT")
        XCTAssertEqual(Business.BusinessType.government.rawValue, "GOVERNMENT")
        XCTAssertEqual(Business.BusinessType.publicCompany.rawValue, "PUBLIC_COMPANY")
        XCTAssertEqual(Business.BusinessType.registered.rawValue, "REGISTERED_COOPERATIVE")
        XCTAssertEqual(Business.BusinessType.proprietory.rawValue, "PROPRIETORY_COMPANY")
        XCTAssertEqual(Business.BusinessType.association.rawValue, "ASSOCIATION")
        XCTAssertEqual(Business.BusinessType.privateCorporation.rawValue, "PRIVATE_CORPORATION")
        XCTAssertEqual(Business.BusinessType.limitedPartnership.rawValue, "LIMITED_PARTNERSHIP")
        XCTAssertEqual(Business.BusinessType.limitedLiabilityProprietors.rawValue, "LIMITED_LIABILITY_PROPRIETORS")
        XCTAssertEqual(Business.BusinessType.limitedLiabilityPrivateCorporation.rawValue, "LIMITED_LIABILITY_PRIVATE_CORPORATION")
        XCTAssertEqual(Business.BusinessType.limitedLiabilityPartnership.rawValue, "LIMITED_LIABILITY_PARTNERSHIP")
        XCTAssertEqual(Business.BusinessType.publicCorporation.rawValue, "PUBLIC_CORPORATION")
        XCTAssertEqual(Business.BusinessType.otherCorporate.rawValue, "OTHER_CORPORATE_BODY")
    }
    
    func testAllCase() {
        XCTAssertEqual(Business.BusinessType.allCases.count, 17)
        XCTAssertEqual(Business.BusinessType.allCases, [
            .individual, .proprietorship, .partnership, .corporation, .nonprofit, .government, .publicCompany, .registered, .proprietory, .association,
            .privateCorporation, .limitedPartnership, .limitedLiabilityProprietors, .limitedLiabilityPrivateCorporation, .limitedLiabilityPartnership,
            .publicCorporation, .otherCorporate
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        
        let limitedLiabilityProprietors = try String(data: encoder.encode(Busi(type: .limitedLiabilityProprietors)), encoding: .utf8)
        let privateCorporation = try String(data: encoder.encode(Busi(type: .privateCorporation)), encoding: .utf8)
        
        XCTAssertEqual(limitedLiabilityProprietors, "{\"type\":\"LIMITED_LIABILITY_PROPRIETORS\"}")
        XCTAssertEqual(privateCorporation, "{\"type\":\"PRIVATE_CORPORATION\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let publicCorporation = """
        {
            "type": "PUBLIC_CORPORATION"
        }
        """.data(using: .utf8)!
        let otherCorporate = """
        {
            "type": "OTHER_CORPORATE_BODY"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Busi.self, from: publicCorporation).type, .publicCorporation)
        try XCTAssertEqual(decoder.decode(Busi.self, from: otherCorporate).type, .otherCorporate)
    }
    
    public static var allTests: [(String, (BusinessTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



