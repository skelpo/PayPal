import XCTest
@testable import PayPal

final class OrderMetadataTests: XCTestCase {
    func testInit()throws {
        let metadata = Order.Metadata(data: ["name": "value"])
        XCTAssertEqual(metadata.data, ["name": "value"])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let metadata = Order.Metadata(data: ["name": "value"])
        let generated = try String(data: encoder.encode(metadata), encoding: .utf8)
        let json = "{\"supplementary_data\":[{\"name\":\"name\",\"value\":\"value\"}]}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "supplementary_data": [
                {
                    "name": "name",
                    "value": "value"
                }
            ]
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Order.Metadata.self, from: json), Order.Metadata(data: ["name": "value"]))
    }
    
    static var allTests: [(String, (OrderMetadataTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





