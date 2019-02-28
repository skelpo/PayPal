import XCTest
@testable import PayPal

public final class TemplateListTests: XCTestCase {
    func testInit()throws {
        let list = Template.List(addresses: [], emails: [], phones: [], templates: [])
        
        XCTAssertNil(list.links)
        XCTAssertEqual(list.addresses, [])
        XCTAssertEqual(list.emails, [])
        XCTAssertEqual(list.phones, [])
        XCTAssertEqual(list.templates, [])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let list = Template.List(addresses: [], emails: [], phones: [], templates: [])
        let generated = try String(data: encoder.encode(list), encoding: .utf8)!
        let json = "{\"templates\":[],\"addresses\":[],\"emails\":[],\"phones\":[]}"
        
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
            "addresses": [],
            "emails": [],
            "phones": [],
            "templates": []
        }
        """.data(using: .utf8)!
        let list = Template.List(addresses: [], emails: [], phones: [], templates: [])
        
        try XCTAssertEqual(list, decoder.decode(Template.List.self, from: json))
    }
    
    public static var allTests: [(String, (TemplateListTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



