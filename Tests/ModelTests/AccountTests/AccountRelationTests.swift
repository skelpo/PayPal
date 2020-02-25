import XCTest
@testable import PayPal

public final class AccountRelationTests: XCTestCase {
    func testInit()throws {
        let relation = AccountRelation(type: .partner, payer: "0F1B22C3-C58C-4CC8-AF83-85659455F85F")
        
        XCTAssertEqual(relation.type, .partner)
        XCTAssertEqual(relation.payer, "0F1B22C3-C58C-4CC8-AF83-85659455F85F")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let relation = AccountRelation(type: .partner, payer: "0F1B22C3-C58C-4CC8-AF83-85659455F85F")
        let generated = try String(data: encoder.encode(relation), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"type\":\"PARTNER\",\"subject_payer_id\":\"0F1B22C3-C58C-4CC8-AF83-85659455F85F\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "type": "PARTNER",
            "subject_payer_id": "0F1B22C3-C58C-4CC8-AF83-85659455F85F"
        }
        """.data(using: .utf8)!
        
        let relation = AccountRelation(type: .partner, payer: "0F1B22C3-C58C-4CC8-AF83-85659455F85F")
        try XCTAssertEqual(relation, decoder.decode(AccountRelation.self, from: json))
    }
    
    public static var allTests: [(String, (AccountRelationTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

