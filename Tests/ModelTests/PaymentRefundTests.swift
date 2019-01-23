import XCTest
import Failable
@testable import PayPal

final class PaymentRefundTests: XCTestCase {
    func testInit()throws {
        let refund = try Payment.Refund(
            amount: DetailedAmount(currency: .usd, total: 10.00, details: nil),
            description: .init("description"),
            reason: .init("reason"),
            invoice: .init("invoice")
        )
        
        XCTAssertEqual(refund.description.value, "description")
        XCTAssertEqual(refund.reason.value, "reason")
        XCTAssertEqual(refund.invoice.value, "invoice")
        XCTAssertEqual(refund.amount, DetailedAmount(currency: .usd, total: 10.00, details: nil))
    }
    
    func testValidations()throws {
        var refund = try Payment.Refund(
            amount: DetailedAmount(currency: .usd, total: 10.00, details: nil),
            description: .init("description"),
            reason: .init("reason"),
            invoice: .init("invoice")
        )
        
        try XCTAssertThrowsError(refund.description <~ String(repeating: "d", count: 256))
        try XCTAssertThrowsError(refund.reason <~ String(repeating: "r", count: 31))
        try XCTAssertThrowsError(refund.invoice <~ String(repeating: "i", count: 128))
        try refund.description <~ String(repeating: "d", count: 255)
        try refund.reason <~  String(repeating: "r", count: 30)
        try refund.invoice <~ String(repeating: "i", count: 127)
        
        
        XCTAssertEqual(refund.description.value, String(repeating: "d", count: 255))
        XCTAssertEqual(refund.reason.value, String(repeating: "r", count: 30))
        XCTAssertEqual(refund.invoice.value, String(repeating: "i", count: 127))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let refund = try Payment.Refund(
            amount: DetailedAmount(currency: .usd, total: 10.00, details: nil),
            description: .init("desc"),
            reason: .init("reas"),
            invoice: .init("inv")
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
            amount: DetailedAmount(currency: .usd, total: 10.00, details: nil),
            description: .init("desc"),
            reason: .init("reas"),
            invoice: .init("inv")
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




