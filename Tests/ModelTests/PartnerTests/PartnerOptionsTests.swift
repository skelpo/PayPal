import XCTest
@testable import PayPal

public final class PartnerOptionsTests: XCTestCase {
    func testInit()throws {
        let dict: PartnerOptions = ["key": "value", "key1": "value1"]
        XCTAssertEqual(dict["key"], "value")
        XCTAssertEqual(dict["key1"], "value1")
        
        let options = PartnerOptions(fields: ["key": "value", "key1": "value1"])
        XCTAssertEqual(options["key"], "value")
        XCTAssertEqual(options["key1"], "value1")
        XCTAssertEqual(options.fields, ["key": "value", "key1": "value1"])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let options: PartnerOptions = ["key": "value", "key1": "value1"]
        let generated = try String(data: encoder.encode(options), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"partner_fields\":[{\"key\":\"key\",\"value\":\"value\"},{\"key\":\"key1\",\"value\":\"value1\"}]}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let mit = """
        {
            "partner_fields": [
                {
                    "key": "key",
                    "value": "value"
                },
                {
                    "key": "key1",
                    "value": "value1"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let options: PartnerOptions = ["key": "value", "key1": "value1"]
        try XCTAssertEqual(options, decoder.decode(PartnerOptions.self, from: mit))
    }
    
    public static var allTests: [(String, (PartnerOptionsTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

