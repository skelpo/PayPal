import XCTest
@testable import PayPal

public final class LinkDescriptionTests: XCTestCase {
    func testInit()throws {
        let link = LinkDescription(href: "https://choosealicense.com/licenses/mit/", rel: "license", method: .GET)
        
        XCTAssertEqual(link.href, "https://choosealicense.com/licenses/mit/")
        XCTAssertEqual(link.rel, "license")
        XCTAssertEqual(link.method, .GET)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let license = try String(data: encoder.encode(
            LinkDescription(href: "https://choosealicense.com/licenses/mit/", rel: "license", method: .GET)
        ), encoding: .utf8)
        
        XCTAssertEqual(license, "{\"rel\":\"license\",\"href\":\"https:\\/\\/choosealicense.com\\/licenses\\/mit\\/\",\"method\":\"GET\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let mit = """
        {
            "rel": "license",
            "href": "https://choosealicense.com/licenses/mit/",
            "method": "GET"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(
            LinkDescription(href: "https://choosealicense.com/licenses/mit/", rel: "license", method: .GET),
            decoder.decode(LinkDescription.self, from: mit)
        )
    }
    
    static var allTests: [(String, (LinkDescriptionTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
