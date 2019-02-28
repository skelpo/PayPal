import XCTest
@testable import PayPal

public final class TemplateTests: XCTestCase {
    func testInit()throws {
        let template = Template(
            name: "Hours Template",
            default: true,
            data: nil,
            settings: [
                .init(field: .itemsDate, preference: .init(hidden: true)),
                .init(field: .custom, preference: .init(hidden: true))
            ],
            measureUnit: .hours
        )
        
        XCTAssertNil(template.data)
        XCTAssertEqual(template.name, "Hours Template")
        XCTAssertEqual(template.default, true)
        XCTAssertEqual(template.measureUnit, .hours)
        
        XCTAssertEqual(template.settings?.count, 2)
        XCTAssertEqual(template.settings?[0], .init(field: .itemsDate, preference: .init(hidden: true)))
        XCTAssertEqual(template.settings?[1], .init(field: .custom, preference: .init(hidden: true)))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let template = Template(
            name: "Hours Template",
            default: true,
            data: nil,
            settings: [
                .init(field: .itemsDate, preference: .init(hidden: true)),
                .init(field: .custom, preference: .init(hidden: true))
            ],
            measureUnit: .hours
        )
        let generated = try String(data: encoder.encode(template), encoding: .utf8)!
        let json =
        "{\"default\":true,\"settings\":[{\"field_name\":\"items.date\",\"display_preference\":{\"hidden\":true}}," +
        "{\"field_name\":\"custom\",\"display_preference\":{\"hidden\":true}}],\"name\":\"Hours Template\",\"unit_of_measure\":\"HOURS\"}"
        
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
            "name": "Hours Template",
            "default": true,
            "settings": [
                {
                    "field_name": "items.date",
                    "display_preference": {
                        "hidden": true
                    }
                },
                {
                    "field_name": "custom",
                    "display_preference": {
                        "hidden": true
                    }
                }
            ],
            "unit_of_measure": "HOURS"
        }
        """.data(using: .utf8)!
        let template = Template(
            name: "Hours Template",
            default: true,
            data: nil,
            settings: [
                .init(field: .itemsDate, preference: .init(hidden: true)),
                .init(field: .custom, preference: .init(hidden: true))
            ],
            measureUnit: .hours
        )
        
        try XCTAssertEqual(template, decoder.decode(Template.self, from: json))
    }
    
    static var allTests: [(String, (TemplateTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


