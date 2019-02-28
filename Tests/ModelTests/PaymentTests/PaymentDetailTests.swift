import XCTest
@testable import PayPal

public final class PaymentDetailTests: XCTestCase {
    let now = Date()
    
    func testInit()throws {
        let detail = PaymentDetail(date: self.now, method: .cash, note: "Hello World", amount: CurrencyAmount(currency: .usd, value: 4.50))
        
        XCTAssertEqual(detail.date, self.now)
        XCTAssertEqual(detail.method, .cash)
        XCTAssertEqual(detail.note, "Hello World")
        XCTAssertEqual(detail.amount, CurrencyAmount(currency: .usd, value: 4.50))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let detail = PaymentDetail(date: self.now, method: .cash, note: "Hello World", amount: CurrencyAmount(currency: .usd, value: 4.50))
        let generated = try String(data: encoder.encode(detail), encoding: .utf8)!
        let json =
            "{\"amount\":{\"currency\":\"USD\",\"value\":\"4.50\"},\"method\":\"CASH\",\"note\":\"Hello World\",\"date\":\"\(self.now.iso8601)\"}"
        
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
        let detail = PaymentDetail(date: self.now, method: .cash, note: "Hello World", amount: CurrencyAmount(currency: .usd, value: 4.50))
        let json = """
        {
            "amount": {
                "currency": "USD",
                "value": "4.50"
            },
            "note": "Hello World",
            "method": "CASH",
            "date": "\(self.now.iso8601)"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(detail, decoder.decode(PaymentDetail.self, from: json))
    }
    
    public static var allTests: [(String, (PaymentDetailTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



