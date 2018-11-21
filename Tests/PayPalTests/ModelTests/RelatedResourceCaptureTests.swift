import XCTest
@testable import PayPal

final class RelatedResourceCaptureTests: XCTestCase {
    func testInit()throws {
        let capture = try RelatedResource.Capture(
            amount: DetailedAmount(currency: .usd, total: "67.23", details: nil),
            isFinal: false,
            invoice: "242841E3-7ADE-4C5C-AC88-78103E2132F2",
            transaction: CurrencyAmount(currency: .usd, value: 2.71),
            payerNote: "Notable text"
        )
        
        XCTAssertNil(capture.id)
        XCTAssertNil(capture.state)
        XCTAssertNil(capture.reason)
        XCTAssertNil(capture.parent)
        XCTAssertNil(capture.created)
        XCTAssertNil(capture.updated)
        XCTAssertNil(capture.links)
        
        XCTAssertEqual(capture.isFinal, false)
        XCTAssertEqual(capture.invoice, "242841E3-7ADE-4C5C-AC88-78103E2132F2")
        XCTAssertEqual(capture.payerNote, "Notable text")
        XCTAssertEqual(capture.transaction, CurrencyAmount(currency: .usd, value: 2.71))
        try XCTAssertEqual(capture.amount, DetailedAmount(currency: .usd, total: "67.23", details: nil))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(RelatedResource.Capture(
            amount: nil,
            isFinal: nil,
            invoice: String(repeating: "i", count: 128),
            transaction: nil,
            payerNote: nil
        ))
        try XCTAssertThrowsError(RelatedResource.Capture(
            amount: nil,
            isFinal: nil,
            invoice: nil,
            transaction: nil,
            payerNote: String(repeating: "p", count: 256)
        ))
        var capture = try RelatedResource.Capture(
            amount: DetailedAmount(currency: .usd, total: "67.23", details: nil),
            isFinal: false,
            invoice: "242841E3-7ADE-4C5C-AC88-78103E2132F2",
            transaction: CurrencyAmount(currency: .usd, value: 2.71),
            payerNote: "Notable text"
        )
        
        try XCTAssertThrowsError(capture.set(\RelatedResource.Capture.invoice <~ String(repeating: "i", count: 128)))
        try XCTAssertThrowsError(capture.set(\RelatedResource.Capture.payerNote <~ String(repeating: "p", count: 256)))
        try capture.set(\RelatedResource.Capture.invoice <~ String(repeating: "i", count: 127))
        try capture.set(\RelatedResource.Capture.payerNote <~ String(repeating: "p", count: 255))
        
        XCTAssertEqual(capture.invoice, String(repeating: "i", count: 127))
        XCTAssertEqual(capture.payerNote, String(repeating: "p", count: 255))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let capture = try RelatedResource.Capture(
            amount: DetailedAmount(currency: .usd, total: "67.23", details: nil),
            isFinal: false,
            invoice: "242841E3-7ADE-4C5C-AC88-78103E2132F2",
            transaction: CurrencyAmount(currency: .usd, value: 2.71),
            payerNote: "Notable text"
        )
        let generated = try String(data: encoder.encode(capture), encoding: .utf8)!
        
        let json = "{\"amount\":{\"currency\":\"USD\",\"total\":\"67.23\"},\"transaction_fee\":{\"value\":\"2.71\",\"currency\":\"USD\"},\"note_to_payer\":\"Notable text\",\"is_final_capture\":false,\"invoice_number\":\"242841E3-7ADE-4C5C-AC88-78103E2132F2\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let created = Date()
        let updated = Date() + (60 * 60 * 24 * 3)
        
        let decoder = JSONDecoder()
        let json = """
        {
            "id": "936863A4-1A6E-4F66-A250-1CCAB0B2E4C8",
            "amount": {
                "currency": "USD",
                "total": "67.23"
            },
            "is_final_capture": false,
            "state": "pending",
            "reason_code": "TRANSACTION_APPROVED_AWAITING_FUNDING",
            "parent_payment": "4690C70C-19B0-4AF7-A7A9-C77C0345C448",
            "invoice_number": "242841E3-7ADE-4C5C-AC88-78103E2132F2",
            "transaction_fee": {
                "currency": "USD",
                "value": "2.71"
            },
            "note_to_payer": "Notable text",
            "create_time": "\(created.iso8601)",
            "update_time": "\(updated.iso8601)",
            "links": []
        }
        """.data(using: .utf8)!
        let invoice = """
        }
            "invoice_number": "\(String(repeating: "i", count: 128))"
        }
        """.data(using: .utf8)!
        let note = """
        {
            "note_to_payer": "\(String(repeating: "n", count: 256))"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(RelatedResource.Capture.self, from: invoice))
        try XCTAssertThrowsError(decoder.decode(RelatedResource.Capture.self, from: note))
        
        let capture = try decoder.decode(RelatedResource.Capture.self, from: json)
        XCTAssertEqual(capture.id, "936863A4-1A6E-4F66-A250-1CCAB0B2E4C8")
        XCTAssertEqual(capture.state, .pending)
        XCTAssertEqual(capture.reason, .awaitingFunding)
        XCTAssertEqual(capture.parent, "4690C70C-19B0-4AF7-A7A9-C77C0345C448")
        XCTAssertEqual(capture.created, created.iso8601)
        XCTAssertEqual(capture.updated, updated.iso8601)
        XCTAssertEqual(capture.links, [])
        XCTAssertEqual(capture.isFinal, false)
        XCTAssertEqual(capture.invoice, "242841E3-7ADE-4C5C-AC88-78103E2132F2")
        XCTAssertEqual(capture.payerNote, "Notable text")
        XCTAssertEqual(capture.transaction, CurrencyAmount(currency: .usd, value: 2.71))
        try XCTAssertEqual(capture.amount, DetailedAmount(currency: .usd, total: "67.23", details: nil))
        
    }
    
    static var allTests: [(String, (RelatedResourceCaptureTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





