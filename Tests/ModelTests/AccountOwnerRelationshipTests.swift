import XCTest
@testable import PayPal

final class AccountOwnerRelationshipTests: XCTestCase {
    func testInit()throws {
        let relationship = try AccountOwnerRelationship(
            name: Name(prefix: nil, given: .init("Abe"), surname: .init("Lincon"), middle: nil, suffix: nil, full: .init("Abe Lincon")),
            country: .unitedStates
        )
        
        XCTAssertEqual(relationship.relation, "MOTHER")
        XCTAssertEqual(relationship.country, .unitedStates)
        try XCTAssertEqual(relationship.name, Name(
            prefix: nil, given: .init("Abe"), surname: .init("Lincon"), middle: nil, suffix: nil, full: .init("Abe Lincon"))
        )
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let relationship = try AccountOwnerRelationship(
            name: Name(prefix: nil, given: .init("Abe"), surname: .init("Lincon"), middle: nil, suffix: nil, full: .init("Abe Lincon")),
            country: .unitedStates
        )
        let generated = try String(data: encoder.encode(relationship), encoding: .utf8)!
        let json =
        "{\"name\":{\"surname\":\"Lincon\",\"given_name\":\"Abe\",\"full_name\":\"Abe Lincon\"},\"relation\":\"MOTHER\",\"country_code_of_nationality\":\"US\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let relationship = try AccountOwnerRelationship(
            name: Name(prefix: nil, given: .init("Abe"), surname: .init("Lincon"), middle: nil, suffix: nil, full: .init("Abe Lincon")),
            country: .unitedStates
        )
        let json = """
        {
            "relation": "MOTHER",
            "country_code_of_nationality": "US",
            "name": {
                "full_name": "Abe Lincon",
                "surname": "Lincon",
                "given_name": "Abe"
            }
        }
        """.data(using: .utf8)!
        let country = """
        {
            "relation": "MOTHER",
            "country_code_of_nationality": "usa",
            "name": {
                "full_name": "Abe Lincon",
                "surname": "Lincon",
                "given_name": "Abe"
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(AccountOwnerRelationship.self, from: country))
        try XCTAssertEqual(relationship, decoder.decode(AccountOwnerRelationship.self, from: json))
    }
    
    static var allTests: [(String, (AccountOwnerRelationshipTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



