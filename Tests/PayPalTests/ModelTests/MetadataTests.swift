import XCTest
@testable import PayPal

final class MetadataTests: XCTestCase {
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let created = Date().iso8601
        let updated = (Date() + (60 * 60 * 24 * 58)).iso8601
        let cancelled = (Date() + (60 * 60 * 24 * 60)).iso8601
        
        let valid = """
        {
            "created_date": "\(created)",
            "created_by": "holmes@bakerstreet.com",
            "cancelled_date": "\(cancelled)",
            "cancelled_by": "actor@figure.com",
            "last_updated_date": "\(updated)",
            "last_updated_by": "another@vapor.com",
            "first_sent_date": "\(created)",
            "last_sent_date": "\(updated)",
            "last_sent_by": "another@vapor.com",
            "payer_view_url": "https://vapor.com/invoices/2620EF1C-4F5D-4479-8657-4DA21B56D023"
        }
        """.data(using: .utf8)!
        
        let metadata = try decoder.decode(Invoice.Metadata.self, from: valid)
        
        XCTAssertEqual(metadata.createdAt, created)
        XCTAssertEqual(metadata.createdBy, "holmes@bakerstreet.com")
        XCTAssertEqual(metadata.cancelledAt, cancelled)
        XCTAssertEqual(metadata.cancelledBy, "actor@figure.com")
        XCTAssertEqual(metadata.lastUpdatedAt, updated)
        XCTAssertEqual(metadata.lastUpdatedBy, "another@vapor.com")
        XCTAssertEqual(metadata.firstSentAt, created)
        XCTAssertEqual(metadata.lastSentAt, updated)
        XCTAssertEqual(metadata.lastSentBy, "another@vapor.com")
        XCTAssertEqual(metadata.payerView, "https://vapor.com/invoices/2620EF1C-4F5D-4479-8657-4DA21B56D023")
    }
    
    static var allTests: [(String, (MetadataTests) -> ()throws -> ())] = [
        ("testDecoding", testDecoding)
    ]
}


