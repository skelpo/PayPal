import XCTest
@testable import PayPal

final class NotificationOptionTests: XCTestCase {
    func testInit()throws {
        let null = NotificationOptions()
        XCTAssertEqual(null.suppressWelcome, nil)
        XCTAssertEqual(null.ipnNotify, nil)
        XCTAssertEqual(null.emailFrequency, nil)
        
        let options = NotificationOptions(suppressWelcome: false, ipnNotify: "https://example.com/ipn/notification", emailFrequency: .default)
        XCTAssertEqual(options.suppressWelcome, false)
        XCTAssertEqual(options.ipnNotify, "https://example.com/ipn/notification")
        XCTAssertEqual(options.emailFrequency, .default)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let options = NotificationOptions(suppressWelcome: false, ipnNotify: "https://example.com/ipn/notification", emailFrequency: .default)
        let generated = try String(data: encoder.encode(options), encoding: .utf8)
        let json =
            "{\"suppress_welcome_email\":false,\"ipn_notify_url\":\"https:\\/\\/example.com\\/ipn\\/notification\"," +
            "\"reminder_email_frequency\":\"DEFAULT\"}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "reminder_email_frequency": "DEFAULT",
            "ipn_notify_url": "https://example.com/ipn/notification",
            "suppress_welcome_email": false
        }
        """.data(using: .utf8)!
        let options = NotificationOptions(suppressWelcome: false, ipnNotify: "https://example.com/ipn/notification", emailFrequency: .default)
        
        try XCTAssertEqual(decoder.decode(NotificationOptions.self, from: json), options)
    }
    
    static var allTests: [(String, (NotificationOptionTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





