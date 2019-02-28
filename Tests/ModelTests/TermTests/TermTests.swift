import XCTest
@testable import PayPal

public final class TermTests: XCTestCase {
    func testInit()throws {
        let term = try Term(
            type: .monthly,
            maxAmount: CurrencyCodeAmount(currency: .usd, value: 14.99),
            occurrences: "1",
            amountRange: CurrencyCodeAmount(currency: .usd, value: 9.99),
            editable: "FALSE"
        )
        
        XCTAssertEqual(term.id, nil)
        XCTAssertEqual(term.type, .monthly)
        XCTAssertEqual(term.occurrences, "1")
        XCTAssertEqual(term.editable, "FALSE")
        XCTAssertEqual(term.amountRange, CurrencyCodeAmount(currency: .usd, value: 9.99))
        XCTAssertEqual(term.maxAmount, CurrencyCodeAmount(currency: .usd, value: 14.99))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let term = try Term(
            type: .monthly,
            maxAmount: CurrencyCodeAmount(currency: .usd, value: 14.99),
            occurrences: "1",
            amountRange: CurrencyCodeAmount(currency: .usd, value: 9.99),
            editable: "FALSE"
        )
        let generated = try String(data: encoder.encode(term), encoding: .utf8)!
        let json =
            "{\"buyer_editable\":\"FALSE\",\"occurrences\":\"1\",\"amount_range\":{\"value\":\"9.99\",\"currency_code\":\"USD\"}," +
            "\"type\":\"MONTHLY\",\"max_billing_amount\":{\"value\":\"14.99\",\"currency_code\":\"USD\"}}"
        
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
            "buyer_editable": "FALSE",
            "amount_range": {
                "value": "9.99",
                "currency_code": "USD"
            },
            "occurrences": "1",
            "max_billing_amount": {
                "value": "14.99",
                "currency_code": "USD\"
            },
            "type": "MONTHLY"
        }
        """.data(using: .utf8)!
        let term = try Term(
            type: .monthly,
            maxAmount: CurrencyCodeAmount(currency: .usd, value: 14.99),
            occurrences: "1",
            amountRange: CurrencyCodeAmount(currency: .usd, value: 9.99),
            editable: "FALSE"
        )
        
        try XCTAssertEqual(term, decoder.decode(Term.self, from: json)
        )
    }
    
    static var allTests: [(String, (TermTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

