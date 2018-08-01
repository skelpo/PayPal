import XCTest
@testable import PayPal

final class MessageTests: XCTestCase {
    func testInit()throws {
        let message = try Message(content: "You might be a developer if you see a music album called J. S. Bach and wonder why it is not called Back.js")
        
        XCTAssertNil(message.posted)
        XCTAssertNil(message.poster)
        XCTAssertEqual(message.content, "You might be a developer if you see a music album called J. S. Bach and wonder why it is not called Back.js")
    }
    
    func testValidation()throws {
        try XCTAssertThrowsError(Message(content: String(repeating: "m", count: 2001)))
        var message = try Message(content: "You might be a developer if you see a music album called J. S. Bach and wonder why it is not called Back.js")
        
        try XCTAssertThrowsError(message.set(\.content <~ String(repeating: "m", count: 2001)))
        try message.set(\.content <~ "<something_witty_here>")
        
        XCTAssertEqual(message.content, "<something_witty_here>")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let message = try Message(content: "<something_witty_here>")
        let generated = try String(data: encoder.encode(message), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"content\":\"<something_witty_here>\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let now = Date()
        let fail = """
        {
            "content": "\(String(repeating: "c", count: 2001))"
        }
        """.data(using: .utf8)!
        let min = """
        {
            "content": "You might be a developer if you see a music album called J. S. Bach and wonder why it is not called Back.js"
        }
        """.data(using: .utf8)!
        let max = """
        {
            "posted_by": "BUYER",
            "time_posted": "\(now.iso8601)",
            "content": "🦄"
        }
        """.data(using: .utf8)!

        try XCTAssertThrowsError(decoder.decode(Message.self, from: fail))
        try XCTAssertEqual(
            decoder.decode(Message.self, from: min),
            Message(content: "You might be a developer if you see a music album called J. S. Bach and wonder why it is not called Back.js")
        )
        
        let message = try decoder.decode(Message.self, from: max)
        XCTAssertEqual(message.poster, .buyer)
        XCTAssertEqual(message.posted, now.iso8601)
        XCTAssertEqual(message.content, "🦄")
    }
    
    static var allTests: [(String, (MessageTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidation", testValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


