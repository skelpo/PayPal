import XCTest
@testable import PayPal

public final class DocumentTests: XCTestCase {
    func testInit()throws {
        let document = Document(name: "README.md", size: "65kb")
        
        XCTAssertEqual(document.name, "README.md")
        XCTAssertEqual(document.size, "65kb")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(Document(name: "README.md", size: "65kb")), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"name\":\"README.md\",\"size\":\"65kb\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "name": "README.md",
            "size": "65kb"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(Document(name: "README.md", size: "65kb"), decoder.decode(Document.self, from: json))
    }
    
    public static var allTests: [(String, (DocumentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



