import XCTest
import Failable
@testable import PayPal

final class MessageTests: XCTestCase {
    func testInit()throws {
        let message = try Message(content: .init("A developer walks into a foo bar and orders a fizz buzz"))
        
        XCTAssertNil(message.posted)
        XCTAssertNil(message.poster)
        XCTAssertEqual(message.content.value, "A developer walks into a foo bar and orders a fizz buzz")
    }
    
    func testValidation()throws {
        var message = try Message(content: .init("A developer walks into a foo bar and orders a fizz buzz"))
        
        try XCTAssertThrowsError(message.content <~ String(repeating: "m", count: 2001))
        try message.content <~ "<something_witty_here>"
        
        XCTAssertEqual(message.content.value, "<something_witty_here>")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let message = try Message(content: .init("<something_witty_here>"))
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
        XCTAssertEqual(message.posted, now)
        XCTAssertEqual(message.content, "🦄")
    }
    
    static var allTests: [(String, (MessageTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidation", testValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


