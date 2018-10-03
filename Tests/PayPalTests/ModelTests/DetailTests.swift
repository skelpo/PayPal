import XCTest
@testable import PayPal

@available(OSX 10.12, *)
final class DetailTests: XCTestCase {
    let now = Date().iso8601
    let later = Date.distantFuture.iso8601
    let oneYear = (Date() + (60 * 60 * 24 * 365)).iso8601
    
    func testInit()throws {
        let details = try Details(
            outstanding: Money(currency: .usd, value: "599.00"),
            cyclesRemaining: "30",
            cyclesComplete: "45",
            nextBilling: oneYear,
            lastPaymentDate: now,
            lastPaymentAmount: Money(currency: .usd, value: "19.97"),
            finalPaymentDate: later,
            failedPaymentCount: "5"
        )
        
        XCTAssertEqual(details.cyclesRemaining, "30")
        XCTAssertEqual(details.cyclesComplete, "45")
        XCTAssertEqual(details.nextBilling, oneYear)
        XCTAssertEqual(details.lastPaymentDate, now)
        XCTAssertEqual(details.finalPaymentDate, later)
        XCTAssertEqual(details.failedPaymentCount, "5")
        
        try XCTAssertEqual(details.lastPaymentAmount, Money(currency: .usd, value: "19.97"))
        try XCTAssertEqual(details.outstanding, Money(currency: .usd, value: "599.00"))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        let details = try Details(
            outstanding: Money(currency: .usd, value: "599.00"),
            cyclesRemaining: "30",
            cyclesComplete: "45",
            nextBilling: oneYear,
            lastPaymentDate: now,
            lastPaymentAmount: Money(currency: .usd, value: "19.97"),
            finalPaymentDate: later,
            failedPaymentCount: "5"
        )
        let generated = try String(data: encoder.encode(details), encoding: .utf8)!
        let json =
            "{\"final_payment_date\":\"\(later)\",\"last_payment_date\":\"\(now)\",\"failed_payment_count\":\"5\"," +
            "\"cycles_remaining\":\"30\",\"cycles_completed\":\"45\",\"last_payment_amount\":{\"value\":\"19.97\",\"currency_code\":\"USD\"}," +
            "\"outstanding_balance\":{\"value\":\"599.00\",\"currency_code\":\"USD\"},\"next_billing_date\":\"\(oneYear)\"}"
        
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
        decoder.dateDecodingStrategy = .iso8601
        
        let json = """
            {
                "outstanding_balance": {
                    "currency_code": "USD",
                    "value": "599.00"
                },
                "cycles_remaining": "30",
                "cycles_completed": "45",
                "next_billing_date": "\(oneYear)",
                "last_payment_date": "\(now)",
                "last_payment_amount": {
                    "currency_code": "USD",
                    "value": "19.97"
                },
                "final_payment_date": "\(later)",
                "failed_payment_count": "5"
            }
        """.data(using: .utf8)!
        
        let decoded = try decoder.decode(Details.self, from: json)
        let details = try Details(
            outstanding: Money(currency: .usd, value: "599.00"),
            cyclesRemaining: "30",
            cyclesComplete: "45",
            nextBilling: oneYear,
            lastPaymentDate: now,
            lastPaymentAmount: Money(currency: .usd, value: "19.97"),
            finalPaymentDate: later,
            failedPaymentCount: "5"
        )
        
        XCTAssertEqual(details.nextBilling, decoded.nextBilling)
        XCTAssertEqual(details.lastPaymentDate, decoded.lastPaymentDate)
        XCTAssertEqual(details.finalPaymentDate, decoded.finalPaymentDate)
        XCTAssertEqual(details, decoded)
    }
    
    static var allTests: [(String, (DetailTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


