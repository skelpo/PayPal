import XCTest
@testable import PayPal

public final class MethodTests: XCTestCase {
    struct Request: Codable {
        let method: PayPal.Method
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Method.GET.rawValue, "GET")
        XCTAssertEqual(Method.POST.rawValue, "POST")
        XCTAssertEqual(Method.PUT.rawValue, "PUT")
        XCTAssertEqual(Method.DELETE.rawValue, "DELETE")
        XCTAssertEqual(Method.HEAD.rawValue, "HEAD")
        XCTAssertEqual(Method.CONNECT.rawValue, "CONNECT")
        XCTAssertEqual(Method.OPTIONS.rawValue, "OPTIONS")
        XCTAssertEqual(Method.PATCH.rawValue, "PATCH")
        XCTAssertEqual(Method.REDIRECT.rawValue, "REDIRECT")
    }
    
    func testAllCase() {
        XCTAssertEqual(Method.allCases.count, 9)
        XCTAssertEqual(Method.allCases, [.GET, .POST, .PUT, .DELETE, .HEAD, .CONNECT, .OPTIONS, .PATCH, .REDIRECT])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let get = try String(data: encoder.encode(Request(method: .GET)), encoding: .utf8)
        let post = try String(data: encoder.encode(Request(method: .POST)), encoding: .utf8)
        
        XCTAssertEqual(get, "{\"method\":\"GET\"}")
        XCTAssertEqual(post, "{\"method\":\"POST\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let put = """
        {
            "method": "PUT"
        }
        """.data(using: .utf8)!
        let delete = """
        {
            "method": "DELETE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Request.self, from: put).method, .PUT)
        try XCTAssertEqual(decoder.decode(Request.self, from: delete).method, .DELETE)
    }
    
    public static var allTests: [(String, (MethodTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

