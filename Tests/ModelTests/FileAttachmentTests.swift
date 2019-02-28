import XCTest
@testable import PayPal

public final class FileAttachmentTests: XCTestCase {
    func testInit()throws {
        let file = FileAttachment(name: "photo.jpg", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")
        
        XCTAssertEqual(file.name, "photo.jpg")
        XCTAssertEqual(file.url, "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let file = FileAttachment(name: "photo.jpg", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")
        let generated = try String(data: encoder.encode(file), encoding: .utf8)!
        
        XCTAssertEqual(generated, "{\"name\":\"photo.jpg\",\"url\":\"https:\\/\\/avatars3.githubusercontent.com\\/u\\/2872298?s=200&v=4\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let ext = """
        {
            "url": "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4",
            "name": "photo.jpg"
        }
        """.data(using: .utf8)!
        
        let file = FileAttachment(name: "photo.jpg", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")
        try XCTAssertEqual(file, decoder.decode(FileAttachment.self, from: ext))
    }
    
    static var allTests: [(String, (FileAttachmentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


