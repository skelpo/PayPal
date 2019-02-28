import XCTest
import JSON
@testable import PayPal

public final class PatchTests: XCTestCase {
    func testInit()throws {
        let patchStr = try Patch(operation: .move, path: "/name", value: "Oskar Reteep", from: "/full_name")
        
        XCTAssertEqual(patchStr.operation, .move)
        XCTAssertEqual(patchStr.path, "/name")
        XCTAssertEqual(patchStr.value, .string("Oskar Reteep"))
        XCTAssertEqual(patchStr.from, "/full_name")
        
        
        let patchArr = try Patch(operation: .add, path: "/cityIDs", value: [1, 2, 6])
        
        XCTAssertEqual(patchArr.operation, .add)
        XCTAssertEqual(patchArr.path, "/cityIDs")
        XCTAssertEqual(patchArr.value, .array([.number(.int(1)), .number(.int(2)), .number(.int(6))]))
        XCTAssertEqual(patchArr.from, nil)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let patchStr = try Patch(operation: .move, path: "/name", value: "Oskar Reteep", from: "/full_name")
        let patchArr = try Patch(operation: .add, path: "/city_ids", value: [1, 2, 6])
        
        let strJson = try String(data: encoder.encode(patchStr), encoding: .utf8)!
        let arrJson = try String(data: encoder.encode(patchArr), encoding: .utf8)!
        
        XCTAssertEqual(strJson, "{\"path\":\"\\/name\",\"value\":\"Oskar Reteep\",\"op\":\"move\",\"from\":\"\\/full_name\"}")
        XCTAssertEqual(arrJson, "{\"path\":\"\\/city_ids\",\"value\":[1,2,6],\"op\":\"add\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let patchStr = try Patch(operation: .move, path: "/name", value: "Oskar Reteep", from: "/full_name")
        let patchArr = try Patch(operation: .add, path: "/city_ids", value: [1, 2, 6])
        
        let strJson = """
        {
            "op": "move",
            "path": "/name",
            "value": "Oskar Reteep",
            "from": "/full_name"
        }
        """.data(using: .utf8)!
        let arrJson = """
        {
            "op": "add",
            "path": "/city_ids",
            "value": [1, 2, 6]
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(patchStr, decoder.decode(Patch.self, from: strJson))
        try XCTAssertEqual(patchArr, decoder.decode(Patch.self, from: arrJson))
    }
    
    static var allTests: [(String, (PatchTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

