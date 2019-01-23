import XCTest
@testable import PayPal

final class InvoicePaymentTests: XCTestCase {
    let now = Date()
    
    func testInit()throws {
        let payment = Invoice.Payment(method: .cash, amount: CurrencyAmount(currency: .usd, value: 20.00), date: self.now, note: "I got the payment by cash!")
        
        XCTAssertEqual(payment.method, .cash)
        XCTAssertEqual(payment.date, self.now)
        XCTAssertEqual(payment.note, "I got the payment by cash!")
        XCTAssertEqual(payment.amount, CurrencyAmount(currency: .usd, value: 20.00))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let payment = Invoice.Payment(method: .cash, amount: CurrencyAmount(currency: .usd, value: 20.00), date: self.now, note: "I got the payment by cash!")
        let generated = try String(data: encoder.encode(payment), encoding: .utf8)!
        let json =
            "{\"amount\":{\"currency\":\"USD\",\"value\":\"20.00\"},\"method\":\"CASH\",\"note\":\"I got the payment by cash!\"," +
            "\"date\":\"\(self.now.iso8601)\"}"
        
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
        let payment = Invoice.Payment(method: .cash, amount: CurrencyAmount(currency: .usd, value: 20.00), date: self.now, note: "I got the payment by cash!")
        
        let json = """
        {
            "method": "CASH",
            "amount": {
                "currency": "USD",
                "value": "20.00"
            },
            "date": "\(self.now.iso8601)",
            "note": "I got the payment by cash!"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(payment, decoder.decode(Invoice.Payment.self, from: json))
    }
    
    static var allTests: [(String, (InvoicePaymentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




