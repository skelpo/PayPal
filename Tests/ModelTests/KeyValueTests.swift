import XCTest
@testable import PayPal

public final class KeyValueTests: XCTestCase {
    func testInit()throws {
        let strd = KeyValue(key: "key0", value: "value0")
        XCTAssertEqual(strd.key, "key0")
        XCTAssertEqual(strd.value, "value0")
        
        let dict: KeyValue = ["key1": "value1", "key12": "value12"]
        XCTAssertEqual(dict.key, "key1")
        XCTAssertEqual(dict.value, "value1")
        let null: KeyValue = [:]
        XCTAssertEqual(null.key, nil)
        XCTAssertEqual(null.value, nil)
        
        let arr: [KeyValue] = ["key2": "value2", "key3": "value3", "key4": "value4", "key5": "value5", "key6": "value6"]
        XCTAssertEqual(arr["key2"], "value2")
        XCTAssertEqual(arr["key3"], "value3")
        XCTAssertEqual(arr["key4"], "value4")
        XCTAssertEqual(arr["key5"], "value5")
        XCTAssertEqual(arr["key6"], "value6")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        
        let key = KeyValue(key: "key0", value: "value0")
        let kgenerated = try String(data: encoder.encode(key), encoding: .utf8)!
        let kjson = "{\"key\":\"key0\",\"value\":\"value0\"}"
        XCTAssertEqual(kgenerated, kjson)
        
        let name = NameValue(key: "key0", value: "value0")
        let ngenerated = try String(data: encoder.encode(name), encoding: .utf8)!
        let njson = "{\"name\":\"key0\",\"value\":\"value0\"}"
        XCTAssertEqual(ngenerated, njson)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let kjson = """
        {
            "key": "key0",
            "value": "value0"
        }
        """.data(using: .utf8)!
        
        let kv = KeyValue(key: "key0", value: "value0")
        try XCTAssertEqual(kv, decoder.decode(KeyValue.self, from: kjson))
        
        let njson = """
        {
            "name": "key0",
            "value": "value0"
        }
        """.data(using: .utf8)!
        
        let nv = NameValue(key: "key0", value: "value0")
        try XCTAssertEqual(nv, decoder.decode(NameValue.self, from: njson))
    }
    
    static var allTests: [(String, (KeyValueTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





