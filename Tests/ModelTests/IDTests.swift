import XCTest
@testable import PayPal

public final class IDTests: XCTestCase {
    func testInit()throws {
        let null = ID()
        let id = ID("P-52603F876DFD4C61")
        let str: ID = "P-52603F876DFD4C61"
        
        XCTAssertEqual(null.id, nil)
        XCTAssertEqual(id.id, "P-52603F876DFD4C61")
        XCTAssertEqual(str.id, "P-52603F876DFD4C61")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let license = try String(data: encoder.encode(ID("P-52603F876DFD4C61")), encoding: .utf8)
        
        XCTAssertEqual(license, "{\"id\":\"P-52603F876DFD4C61\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let mit = """
        {
            "id": "P-52603F876DFD4C61"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual("P-52603F876DFD4C61", decoder.decode(ID.self, from: mit))
    }
    
    public static var allTests: [(String, (IDTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

