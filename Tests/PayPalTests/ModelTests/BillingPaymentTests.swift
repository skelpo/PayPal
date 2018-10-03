import XCTest
@testable import PayPal

final class BillingPaymentTests: XCTestCase {
    func testInit()throws {
        let payment = try BillingPayment(
            name: "Service Membership",
            type: .regular,
            interval: "2",
            frequency: .month,
            cycles: "0",
            amount: Money(currency: .usd, value: "24.99"),
            charges: nil
        )
        
        XCTAssertEqual(payment.id, nil)
        XCTAssertEqual(payment.name, "Service Membership")
        XCTAssertEqual(payment.type, .regular)
        XCTAssertEqual(payment.interval, "2")
        XCTAssertEqual(payment.frequency, .month)
        XCTAssertEqual(payment.cycles, "0")
        XCTAssertEqual(payment.charges, nil)
        try XCTAssertEqual(payment.amount, Money(currency: .usd, value: "24.99"))
        
        try XCTAssertThrowsError(BillingPayment(
            name: "Service Membership",
            type: .regular,
            interval: "i",
            frequency: .month,
            cycles: "0",
            amount: Money(currency: .usd, value: "24.99"),
            charges: nil
        ))
        try XCTAssertThrowsError(BillingPayment(
            name: "Service Membership",
            type: .regular,
            interval: "i",
            frequency: .month,
            cycles: "y",
            amount: Money(currency: .usd, value: "24.99"),
            charges: nil
        ))
        try XCTAssertThrowsError(BillingPayment(
            name: "Service Membership",
            type: .regular,
            interval: "13",
            frequency: .month,
            cycles: "0",
            amount: Money(currency: .usd, value: "24.99"),
            charges: nil
        ))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let payment = try BillingPayment(
            name: "Service Membership",
            type: .regular,
            interval: "2",
            frequency: .month,
            cycles: "0",
            amount: Money(currency: .usd, value: "24.99"),
            charges: nil
        )
        let generated = try String(data: encoder.encode(payment), encoding: .utf8)!
        let json =
            "{\"cycles\":\"0\",\"amount\":{\"value\":\"24.99\",\"currency_code\":\"USD\"},\"frequency_interval\":\"2\",\"name\":\"Service Membership\"," +
            "\"type\":\"REGULAR\",\"frequency\":\"MONTH\"}"
        
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
            name: "Service Membership",
            type: .regular,
            interval: "2",
            frequency: .month,
            cycles: "0",
            amount: Money(currency: .usd, value: "24.99"),
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
        let intervalError = """
        {
            "amount": {
                "currency_code": "USD",
                "value": "24.99"
            },
            "cycles": "0",
            "frequency": "MONTH",
            "frequency_interval": "13",
            "type": "REGULAR",
            "name": "Service Membership"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(payment, decoder.decode(BillingPayment<Money>.self, from: valid))
        try XCTAssertThrowsError(decoder.decode(BillingPayment<Money>.self, from: cyclesError))
        try XCTAssertThrowsError(decoder.decode(BillingPayment<Money>.self, from: intervalError))
    }
    
    static var allTests: [(String, (BillingPaymentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

