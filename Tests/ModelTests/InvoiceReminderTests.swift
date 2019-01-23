import XCTest
@testable import PayPal

final class InvoiceReminderTests: XCTestCase {
    func testInit()throws {
        let reminder = Invoice.Reminder(subject: "Invoice Not Sent", note: "Please send the money", emails: [.init(email: "payer@example.com")])
        
        XCTAssertEqual(reminder.subject, "Invoice Not Sent")
        XCTAssertEqual(reminder.note, "Please send the money")
        XCTAssertEqual(reminder.emails, [.init(email: "payer@example.com")])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let reminder = Invoice.Reminder(subject: "Invoice Not Sent", note: "Please send the money", emails: [.init(email: "payer@example.com")])
        let generated = try String(data: encoder.encode(reminder), encoding: .utf8)!
        let json =
            "{\"subject\":\"Invoice Not Sent\",\"send_to_merchant\":true,\"emails\":[{\"cc_email\":\"payer@example.com\"}],\"note\":\"Please send the money\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "note": "Please send the money",
            "subject": "Invoice Not Sent",
            "emails": [
                {
                    "cc_email": "payer@example.com"
                }
            ],
            "send_to_merchant": true
        }
        """.data(using: .utf8)!
        
        let reminder = Invoice.Reminder(subject: "Invoice Not Sent", note: "Please send the money", emails: [.init(email: "payer@example.com")])
        try XCTAssertEqual(reminder, decoder.decode(Invoice.Reminder.self, from: json))
    }
    
    static var allTests: [(String, (InvoiceReminderTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



