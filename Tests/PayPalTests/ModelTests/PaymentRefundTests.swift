import XCTest
@testable import PayPal

final class PaymentRefundTests: XCTestCase {
    func testInit()throws {
        let refund = try Payment.Refund(
            amount: DetailedAmount(currency: .usd, total: "10.00", details: nil),
            description: "description",
            reason: "reason",
            invoice: "invoice"
        )
        
        XCTAssertEqual(refund.description, "description")
        XCTAssertEqual(refund.reason, "reason")
        XCTAssertEqual(refund.invoice, "invoice")
        try XCTAssertEqual(refund.amount, DetailedAmount(currency: .usd, total: "10.00", details: nil))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Payment.Refund(amount: nil, description: String(repeating: "d", count: 256), reason: nil, invoice: nil))
        try XCTAssertThrowsError(Payment.Refund(amount: nil, description: nil, reason: String(repeating: "r", count: 31), invoice: nil))
        try XCTAssertThrowsError(Payment.Refund(amount: nil, description: nil, reason: nil, invoice: String(repeating: "i", count: 128)))
        var refund = try Payment.Refund(
            amount: DetailedAmount(currency: .usd, total: "10.00", details: nil),
            description: "description",
            reason: "reason",
            invoice: "invoice"
        )
        
        try XCTAssertThrowsError(refund.set(\Payment.Refund.description, to:  String(repeating: "d", count: 256)))
        try XCTAssertThrowsError(refund.set(\Payment.Refund.reason, to:  String(repeating: "r", count: 31)))
        try XCTAssertThrowsError(refund.set(\Payment.Refund.invoice, to:  String(repeating: "i", count: 128)))
        try refund.set(\Payment.Refund.description, to:  String(repeating: "d", count: 255))
        try refund.set(\Payment.Refund.reason, to:  String(repeating: "r", count: 30))
        try refund.set(\Payment.Refund.invoice, to:  String(repeating: "i", count: 127))
        
        
        XCTAssertEqual(refund.description, String(repeating: "d", count: 255))
        XCTAssertEqual(refund.reason, String(repeating: "r", count: 30))
        XCTAssertEqual(refund.invoice, String(repeating: "i", count: 127))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let refund = try Payment.Refund(
            amount: DetailedAmount(currency: .usd, total: "10.00", details: nil),
            description: "desc",
            reason: "reas",
            invoice: "inv"
        )
        let generated = try String(data: encoder.encode(refund), encoding: .utf8)!
        let json = "{\"amount\":{\"currency\":\"USD\",\"total\":\"10.00\"},\"reason\":\"reas\",\"description\":\"desc\",\"invoice_number\":\"inv\"}"
        
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
            "amount": {
                "currency": "USD",
                "total": "10.00"
            },
            "description": "desc",
            "reason": "reas",
            "invoice_number": "inv"
        }
        """.data(using: .utf8)!
       
        let refund = try Payment.Refund(
            amount: DetailedAmount(currency: .usd, total: "10.00", details: nil),
            description: "desc",
            reason: "reas",
            invoice: "inv"
        )
        try XCTAssertEqual(refund, decoder.decode(Payment.Refund.self, from: json))
    }
    
    static var allTests: [(String, (PaymentRefundTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




