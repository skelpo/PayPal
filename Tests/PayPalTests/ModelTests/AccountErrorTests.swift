import XCTest
@testable import PayPal

final class AccountErrorTests: XCTestCase {
    func testInit()throws {
        let error = AccountError(name: "invalidTimezone", message: "Chosen timezone does not appear to exist", debug: "5698", details: [])
        
        XCTAssertEqual(error.name, "invalidTimezone")
        XCTAssertEqual(error.message, "Chosen timezone does not appear to exist")
        XCTAssertEqual(error.debug, "5698")
        XCTAssertEqual(error.details, [])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let error = AccountError(name: "invalidTimezone", message: "Chosen timezone does not appear to exist", debug: "5698", details: [])
        let generated = try String(data: encoder.encode(error), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"message\":\"Chosen timezone does not appear to exist\",\"details\":[],\"debug_id\":\"5698\",\"name\":\"invalidTimezone\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "details": [],
            "debug_id": "5698",
            "message": "Chosen timezone does not appear to exist",
            "name": "invalidTimezone",
            "information_link": "https://example.com/errors/5698",
            "links": []
        }
        """.data(using: .utf8)!
        
        let error = try decoder.decode(AccountError.self, from: json)
        XCTAssertEqual(error.name, "invalidTimezone")
        XCTAssertEqual(error.message, "Chosen timezone does not appear to exist")
        XCTAssertEqual(error.debug, "5698")
        XCTAssertEqual(error.details, [])
        XCTAssertEqual(error.links, [])
        XCTAssertEqual(error.information, "https://example.com/errors/5698")
    }
    
    static var allTests: [(String, (AccountErrorTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


