import XCTest
@testable import PayPal

public final class InvoiceSearchTests: XCTestCase {
    let now = Date()
    let later = (Date() + 60 * 60 * 24 * 60)
    
    func testInit()throws {
        let search = Invoice.Search(
            startInvoiceAt: self.now,
            endInvoiceAt: self.later,
            page: 0,
            pageSize: 3,
            totalCount: true
        )
        
        XCTAssertNil(search.email)
        XCTAssertNil(search.firstName)
        XCTAssertNil(search.lastName)
        XCTAssertNil(search.businessName)
        XCTAssertNil(search.lowerAmount)
        XCTAssertNil(search.upperAmount)
        XCTAssertNil(search.startDueAt)
        XCTAssertNil(search.endDueAt)
        XCTAssertNil(search.startPaymentAt)
        XCTAssertNil(search.endPaymentAt)
        XCTAssertNil(search.startCreationAt)
        XCTAssertNil(search.endCreationAt)
        XCTAssertNil(search.archived)
        
        XCTAssertEqual(search.startInvoiceAt, self.now)
        XCTAssertEqual(search.endInvoiceAt, self.later)
        XCTAssertEqual(search.page, 0)
        XCTAssertEqual(search.pageSize, 3)
        XCTAssertEqual(search.totalCount, true)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let search = Invoice.Search(
            startInvoiceAt: self.now,
            endInvoiceAt: self.later,
            page: 0,
            pageSize: 3,
            totalCount: true
        )
        let generated = try String(data: encoder.encode(search), encoding: .utf8)!
        let json =
            "{\"page_size\":3,\"total_count_required\":true,\"end_invoice_date\":\"\(self.later.iso8601)\"," +
            "\"start_invoice_date\":\"\(self.now.iso8601)\",\"page\":0}"
        
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
            "start_invoice_date": "\(self.now.iso8601)",
            "end_invoice_date": "\(self.later.iso8601)",
            "page": 0,
            "page_size": 3,
            "total_count_required": true
        }
        """.data(using: .utf8)!
        
        let search = Invoice.Search(
            startInvoiceAt: self.now,
            endInvoiceAt: self.later,
            page: 0,
            pageSize: 3,
            totalCount: true
        )
        try XCTAssertEqual(search, decoder.decode(Invoice.Search.self, from: json))
    }
    
    public static var allTests: [(String, (InvoiceSearchTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




