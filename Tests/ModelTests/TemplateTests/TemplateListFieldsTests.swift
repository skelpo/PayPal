import XCTest
@testable import PayPal

public final class TemplateListFieldsTests: XCTestCase {
    struct List: Codable {
        let field: Template.ListFields
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Template.ListFields.none.rawValue, "none")
        XCTAssertEqual(Template.ListFields.all.rawValue, "all")
    }
    
    func testAllCase() {
        XCTAssertEqual(Template.ListFields.allCases.count, 2)
        XCTAssertEqual(Template.ListFields.allCases, [.none, .all])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let none = try String(data: encoder.encode(List(field: .none)), encoding: .utf8)
        let all = try String(data: encoder.encode(List(field: .all)), encoding: .utf8)
        
        XCTAssertEqual(none, "{\"field\":\"none\"}")
        XCTAssertEqual(all, "{\"field\":\"all\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let none = """
        {
            "field": "none"
        }
        """.data(using: .utf8)!
        let all = """
        {
            "field": "all"
        }
        """
        
        try XCTAssertEqual(decoder.decode(List.self, from: none).field, .none)
        try XCTAssertEqual(decoder.decode(List.self, from: all).field, .all)
    }
    
    public static var allTests: [(String, (TemplateListFieldsTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



