import XCTest
@testable import PayPal

public final class GovernmentBodyTests: XCTestCase {
    func testInit()throws {
        let govt = GovernmentBody(name: "value")
        
        XCTAssertEqual(govt.name, "value")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let json = try String(data: encoder.encode(GovernmentBody(name: "value")), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"name\":\"value\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "name": "value"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(GovernmentBody(name: "value"), decoder.decode(GovernmentBody.self, from: json))
    }
    
    public static var allTests: [(String, (GovernmentBodyTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


