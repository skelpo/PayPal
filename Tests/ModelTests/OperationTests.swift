import XCTest
@testable import PayPal

public final class OperationTests: XCTestCase {
    struct Patch: Codable {
        let operation: PayPal.Operation
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Operation.add.rawValue, "add")
        XCTAssertEqual(Operation.remove.rawValue, "remove")
        XCTAssertEqual(Operation.replace.rawValue, "replace")
        XCTAssertEqual(Operation.move.rawValue, "move")
        XCTAssertEqual(Operation.copy.rawValue, "copy")
        XCTAssertEqual(Operation.test.rawValue, "test")
    }
    
    func testAllCase() {
        XCTAssertEqual(Operation.allCases.count, 6)
        XCTAssertEqual(Operation.allCases, [.add, .remove, .replace, .move, .copy, .test])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let add = try String(data: encoder.encode(Patch(operation: .add)), encoding: .utf8)
        let remove = try String(data: encoder.encode(Patch(operation: .remove)), encoding: .utf8)
        
        XCTAssertEqual(add, "{\"operation\":\"add\"}")
        XCTAssertEqual(remove, "{\"operation\":\"remove\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let replace = """
        {
            "operation": "replace"
        }
        """.data(using: .utf8)!
        let test = """
        {
            "operation": "test"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Patch.self, from: replace).operation, .replace)
        try XCTAssertEqual(decoder.decode(Patch.self, from: test).operation, .test)
    }
    
    static var allTests: [(String, (OperationTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


