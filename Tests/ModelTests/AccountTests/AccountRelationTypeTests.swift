import XCTest
@testable import PayPal

typealias RelationType = AccountRelation.RelationType

public final class AccountRelationTypeTests: XCTestCase {
    struct Relation: Codable {
        let type: RelationType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(RelationType.partner.rawValue, "PARTNER")
        XCTAssertEqual(RelationType.same.rawValue, "SAME_MERCHANT")
    }
    
    func testAllCase() {
        XCTAssertEqual(RelationType.allCases.count, 2)
        XCTAssertEqual(RelationType.allCases, [.partner, .same])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let partner = try String(data: encoder.encode(Relation(type: .partner)), encoding: .utf8)
        let same = try String(data: encoder.encode(Relation(type: .same)), encoding: .utf8)
        
        XCTAssertEqual(partner, "{\"type\":\"PARTNER\"}")
        XCTAssertEqual(same, "{\"type\":\"SAME_MERCHANT\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let partner = """
        {
            "type": "PARTNER"
        }
        """.data(using: .utf8)!
        let same = """
        {
            "type": "SAME_MERCHANT"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Relation.self, from: partner).type, .partner)
        try XCTAssertEqual(decoder.decode(Relation.self, from: same).type, .same)
    }
    
    public static var allTests: [(String, (AccountRelationTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






