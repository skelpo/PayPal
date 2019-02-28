import XCTest
@testable import PayPal

final class BillingPaymentTests: XCTestCase {
    func testInit()throws {
        let payment = try BillingPayment(
            name: .init("Service Membership"),
            type: .regular,
            interval: 2,
            frequency: .month,
            cycles: 0,
            amount: CurrencyCodeAmount(currency: .usd, value: 24.99),
            charges: nil
        )
        
        XCTAssertNil(payment.id)
        XCTAssertEqual(payment.name.value, "Service Membership")
        XCTAssertEqual(payment.type, .regular)
        XCTAssertEqual(payment.interval, 2)
        XCTAssertEqual(payment.frequency, .month)
        XCTAssertEqual(payment.cycles, 0)
        XCTAssertEqual(payment.charges, nil)
        XCTAssertEqual(payment.amount, CurrencyCodeAmount(currency: .usd, value: 24.99))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let payment = try BillingPayment(
            name: .init("Service Membership"),
            type: .regular,
            interval: 2,
            frequency: .month,
            cycles: 0,
            amount: CurrencyCodeAmount(currency: .usd, value: 24.99),
            charges: nil
        )
        let generated = try String(data: encoder.encode(payment), encoding: .utf8)!
        let json =
            "{\"frequency\":\"MONTH\",\"amount\":{\"value\":\"24.99\",\"currency_code\":\"USD\"},\"frequency_interval\":\"2\",\"cycles\":\"0\"," +
            "\"name\":\"Service Membership\",\"type\":\"REGULAR\"}"
        
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
        let payment = try BillingPayment(
            name: .init("Service Membership"),
            type: .regular,
            interval: 2,
            frequency: .month,
            cycles: 0,
            amount: CurrencyCodeAmount(currency: .usd, value: 24.99),
            charges: nil
        )
        
        let valid = """
        {
            "amount": {
                "currency_code": "USD",
                "value": "24.99"
            },
            "cycles": "0",
            "frequency": "MONTH",
            "frequency_interval": "2",
            "type": "REGULAR",
            "name": "Service Membership"
        }
        """.data(using: .utf8)!
        let cyclesError = """
        {
            "amount": {
                "currency_code": "USD",
                "value": "24.99"
            },
            "cycles": "i",
            "frequency": "MONTH",
            "frequency_interval": "2",
            "type": "REGULAR",
            "name": "Service Membership"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(payment, decoder.decode(BillingPayment<CurrencyCodeAmount>.self, from: valid))
        try XCTAssertThrowsError(decoder.decode(BillingPayment<CurrencyCodeAmount>.self, from: cyclesError))
    }
    
    static var allTests: [(String, (BillingPaymentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

