import XCTest
@testable import PayPal

public final class RedirectsTests: XCTestCase {
    func testInit()throws {
        let redirects = Redirects(return: "https://example.com/return", cancel: "https://example.com/cancel")
        
        XCTAssertEqual(redirects.return, "https://example.com/return")
        XCTAssertEqual(redirects.cancel, "https://example.com/cancel")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let redirects = Redirects(return: "https://example.com/return", cancel: "https://example.com/cancel")
        let generated = try String(data: encoder.encode(redirects), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"return_url\":\"https:\\/\\/example.com\\/return\",\"cancel_url\":\"https:\\/\\/example.com\\/cancel\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "return_url": "https://example.com/return",
            "cancel_url": "https://example.com/cancel"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(Redirects(return: "https://example.com/return", cancel: "https://example.com/cancel"), decoder.decode(Redirects.self, from: json))
    }
    
    public static var allTests: [(String, (RedirectsTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




