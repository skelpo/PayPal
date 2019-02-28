import XCTest
import Failable
@testable import PayPal

final class PaymentRefundResultTests: XCTestCase {
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "id": "5CY176817C379973E",
            "create_time": "2018-08-15T17:11:32Z",
            "update_time": "2018-08-15T17:11:32Z",
            "state": "completed",
            "reason": "I don't like it",
            "amount": {
                "total": "2.34",
                "currency": "USD"
            },
            "refund_from_transaction_fee": {
                "currency": "USD",
                "value": "0.06"
            },
            "total_refunded_amount": {
                "currency": "USD",
                "value": "2.34"
            },
            "refund_from_received_amount": {
                "currency": "USD",
                "value": "2.28"
            },
            "sale_id": "2MU78835H4515710F",
            "capture_id": "51D1E23219A64A268",
            "parent_payment": "PAY-9EH2230144138005NLN2F4EA",
            "description": "It's icky",
            "invoice_number": "INV-1234567",
            "custom": "Dear Payer...",
            "links": []
        }
        """.data(using: .utf8)!
        
        var refund = try decoder.decode(Payment.RefundResult.self, from: json)
        
        XCTAssertEqual(refund.id, "5CY176817C379973E")
        XCTAssertEqual(refund.created, Date(iso8601: "2018-08-15T17:11:32Z"))
        XCTAssertEqual(refund.updated, Date(iso8601: "2018-08-15T17:11:32Z"))
        XCTAssertEqual(refund.state, .completed)
        XCTAssertEqual(refund.reason, "I don't like it")
        XCTAssertEqual(refund.sale, "2MU78835H4515710F")
        XCTAssertEqual(refund.capture, "51D1E23219A64A268")
        XCTAssertEqual(refund.parent, "PAY-9EH2230144138005NLN2F4EA")
        XCTAssertEqual(refund.invoice.value, "INV-1234567")
        XCTAssertEqual(refund.description, "It's icky")
        XCTAssertEqual(refund.custom.value, "Dear Payer...")
        XCTAssertEqual(refund.links, [])
        
        XCTAssertEqual(refund.amount, DetailedAmount(currency: .usd, total: 2.34, details: nil))
        XCTAssertEqual(refund.transactionFee, CurrencyAmount(currency: .usd, value: 0.06))
        XCTAssertEqual(refund.received, CurrencyAmount(currency: .usd, value: Decimal(sign: .plus, exponent: -2, significand: 228)))
        XCTAssertEqual(refund.total, CurrencyAmount(currency: .usd, value: 2.34))
        
        
        try XCTAssertThrowsError(refund.invoice <~ String(repeating: "i", count: 128))
        try XCTAssertThrowsError(refund.custom <~ String(repeating: "c", count: 128))
        try refund.invoice <~ String(repeating: "i", count: 127)
        try refund.custom <~ String(repeating: "c", count: 127)

        XCTAssertEqual(refund.invoice.value, String(repeating: "i", count: 127))
        XCTAssertEqual(refund.custom.value, String(repeating: "c", count: 127))
    }
    
    static var allTests: [(String, (PaymentRefundResultTests) -> ()throws -> ())] = [
        ("testDecoding", testDecoding)
    ]
}
