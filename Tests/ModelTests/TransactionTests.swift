import XCTest
@testable import PayPal

final class TransactionTests: XCTestCase {
    func testInit()throws {
        let transaction = Transaction(
            amount: CurrencyCodeAmount(currency: .usd, value: 79.25),
            fee: CurrencyCodeAmount(currency: .usd, value: 7.25),
            net: CurrencyCodeAmount(currency: .usd, value: 72.00)
        )
        
        XCTAssertEqual(transaction.id, nil)
        XCTAssertEqual(transaction.state, nil)
        XCTAssertEqual(transaction.type, nil)
        XCTAssertEqual(transaction.email, nil)
        XCTAssertEqual(transaction.name, nil)
        XCTAssertEqual(transaction.timestamp, nil)
        XCTAssertEqual(transaction.timezone, nil)
        
        XCTAssertEqual(transaction.amount, CurrencyCodeAmount(currency: .usd, value: 79.25))
        XCTAssertEqual(transaction.fee, CurrencyCodeAmount(currency: .usd, value: 7.25))
        XCTAssertEqual(transaction.net, CurrencyCodeAmount(currency: .usd, value: 72.00))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let transaction = Transaction(
            amount: CurrencyCodeAmount(currency: .usd, value: 79.25),
            fee: CurrencyCodeAmount(currency: .usd, value: 7.25),
            net: CurrencyCodeAmount(currency: .usd, value: 72.00)
        )
        let generated = try String(data: encoder.encode(transaction), encoding: .utf8)
        let json =
            "{\"amount\":{\"value\":\"79.25\",\"currency_code\":\"USD\"},\"fee_amount\":{\"value\":\"7.25\",\"currency_code\":\"USD\"}," +
            "\"net_amount\":{\"value\":\"72\",\"currency_code\":\"USD\"}}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let minimum = """
        {
            "net_amount": {
                "currency_code": "USD",
                "value": "72.00"
            },
            "fee_amount": {
                "currency_code": "USD",
                "value": "7.25"
            },
            "amount": {
                "currency_code": "USD",
                "value": "79.25"
            }
        }
        """.data(using: .utf8)!
        let full = """
        {
            "transaction_id": "3C3A7405-132B-4516-97AA-51ADE9DC77C6",
            "state": "Completed",
            "transaction_type": "Recurring Payment",
            "payer_email": "3E6F6A01-BB46-440E-B41D-9C2D611041E8",
            "payer_name": "Skelpo Inc.",
            "time_stamp": "2018-07-23T17:24:48Z",
            "time_zone": "CDT",
            "net_amount": {
                "currency_code": "USD",
                "value": "72.00"
            },
            "fee_amount": {
                "currency_code": "USD",
                "value": "7.25"
            },
            "amount": {
                "currency_code": "USD",
                "value": "79.25"
            }
        }
        """.data(using: .utf8)!
        let transaction = try decoder.decode(Transaction.self, from: full)
        
        try XCTAssertEqual(Transaction(
            amount: CurrencyCodeAmount(currency: .usd, value: 79.25),
            fee: CurrencyCodeAmount(currency: .usd, value: 7.25),
            net: CurrencyCodeAmount(currency: .usd, value: 72.00)
        ), decoder.decode(Transaction.self, from: minimum))
        
        XCTAssertEqual(transaction.id, "3C3A7405-132B-4516-97AA-51ADE9DC77C6")
        XCTAssertEqual(transaction.state, .completed)
        XCTAssertEqual(transaction.type, "Recurring Payment")
        XCTAssertEqual(transaction.email, "3E6F6A01-BB46-440E-B41D-9C2D611041E8")
        XCTAssertEqual(transaction.name, "Skelpo Inc.")
        XCTAssertEqual(transaction.timestamp, Date(iso8601: "2018-07-23T17:24:48Z")!)
        XCTAssertEqual(transaction.timezone, "CDT")
        XCTAssertEqual(transaction.amount, CurrencyCodeAmount(currency: .usd, value: 79.25))
        XCTAssertEqual(transaction.fee, CurrencyCodeAmount(currency: .usd, value: 7.25))
        XCTAssertEqual(transaction.net, CurrencyCodeAmount(currency: .usd, value: 72.00))
    }
    
    static var allTests: [(String, (TransactionTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



