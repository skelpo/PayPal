import XCTest
@testable import PayPal

public final class TemplateSettingsTests: XCTestCase {
    func testInit()throws {
        let settings = Template.Settings(field: .itemsDescription, preference: .init(hidden: true))
        
        XCTAssertEqual(settings.field, .itemsDescription)
        XCTAssertEqual(settings.preference?.hidden, true)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let settings = Template.Settings(field: .itemsDescription, preference: .init(hidden: true))
        let generated = try String(data: encoder.encode(settings), encoding: .utf8)!
        let json = "{\"field_name\":\"items.description\",\"display_preference\":{\"hidden\":true}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "field_name": "items.description",
            "display_preference": {
                "hidden": true
            }
        }
        """.data(using: .utf8)!
        
        let settings = Template.Settings(field: .itemsDescription, preference: .init(hidden: true))
        try XCTAssertEqual(settings, decoder.decode(Template.Settings.self, from: json))
    }
    
    static var allTests: [(String, (TemplateSettingsTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


