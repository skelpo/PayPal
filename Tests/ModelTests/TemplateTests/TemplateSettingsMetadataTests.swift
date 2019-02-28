import XCTest
@testable import PayPal

public final class TemplateSettingsMetadataTests: XCTestCase {
    func testInit()throws {
        let metadata = Template.Settings.Metadata(hidden: false)
        
        XCTAssertEqual(metadata.hidden, false)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let metadata = Template.Settings.Metadata(hidden: false)
        let generated = try String(data: encoder.encode(metadata), encoding: .utf8)!
        let json = "{\"hidden\":false}"
        
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
            "hidden": false
        }
        """.data(using: .utf8)!
        let metadata = Template.Settings.Metadata(hidden: false)
        
        try XCTAssertEqual(metadata, decoder.decode(Template.Settings.Metadata.self, from: json))
    }
    
    static var allTests: [(String, (TemplateSettingsMetadataTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


