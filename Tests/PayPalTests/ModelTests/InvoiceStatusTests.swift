import XCTest
@testable import PayPal

final class InvoiceStatusTests: XCTestCase {
    
    struct Inv: Codable {
        let status: Invoice.Status
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Invoice.Status.draft.rawValue, "DRAFT")
        XCTAssertEqual(Invoice.Status.unpaid.rawValue, "UNPAID")
        XCTAssertEqual(Invoice.Status.sent.rawValue, "SENT")
        XCTAssertEqual(Invoice.Status.scheduled.rawValue, "SCHEDULED")
        XCTAssertEqual(Invoice.Status.partiallyPaid.rawValue, "PARTIALLY_PAID")
        XCTAssertEqual(Invoice.Status.pending.rawValue, "PAYMENT_PENDING")
        XCTAssertEqual(Invoice.Status.paid.rawValue, "PAID")
        XCTAssertEqual(Invoice.Status.markedPaid.rawValue, "MARKED_AS_PAID")
        XCTAssertEqual(Invoice.Status.cancelled.rawValue, "CANCELLED")
        XCTAssertEqual(Invoice.Status.refunded.rawValue, "REFUNDED")
        XCTAssertEqual(Invoice.Status.partiallyRefunded.rawValue, "PARTIALLY_REFUNDED")
        XCTAssertEqual(Invoice.Status.markedRefunded.rawValue, "MARKED_AS_REFUNDED")
    }
    
    func testAllCase() {
        XCTAssertEqual(Invoice.Status.allCases.count, 12)
        XCTAssertEqual(Invoice.Status.allCases, [
            .draft, .unpaid, .sent, .scheduled, .partiallyPaid, .pending, .paid, .markedPaid, .cancelled, .refunded, .partiallyRefunded, .markedRefunded
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let draft = try String(data: encoder.encode(Inv(status: .draft)), encoding: .utf8)
        let unpaid = try String(data: encoder.encode(Inv(status: .unpaid)), encoding: .utf8)
        
        XCTAssertEqual(draft, "{\"status\":\"DRAFT\"}")
        XCTAssertEqual(unpaid, "{\"status\":\"UNPAID\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let sent = """
        {
            "status": "SENT"
        }
        """.data(using: .utf8)!
        let scheduled = """
        {
            "status": "SCHEDULED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Inv.self, from: sent).status, .sent)
        try XCTAssertEqual(decoder.decode(Inv.self, from: scheduled).status, .scheduled)
    }
    
    static var allTests: [(String, (InvoiceStatusTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


