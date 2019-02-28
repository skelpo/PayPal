import XCTest
@testable import PayPal

public final class MerchantPreferancesTests: XCTestCase {
    func testInit()throws {
        let preferances = MerchantPreferances(
            setupFee: CurrencyCodeAmount(currency: .usd, value: 0),
            cancelURL: "https://example.com/agreements",
            returnURL: "https://example.com/agreements/latest",
            autoBill: .yes,
            initialFailAction: .continue,
            acceptedPaymentType: nil,
            charSet: "UTF-8"
        )
        
        XCTAssertEqual(preferances.setupFee, CurrencyCodeAmount(currency: .usd, value: 0))
        XCTAssertEqual(preferances.id, nil)
        XCTAssertEqual(preferances.cancelURL, "https://example.com/agreements")
        XCTAssertEqual(preferances.returnURL, "https://example.com/agreements/latest")
        XCTAssertEqual(preferances.maxFails, "0")
        XCTAssertEqual(preferances.autoBill, .yes)
        XCTAssertEqual(preferances.initialFailAction, .continue)
        XCTAssertEqual(preferances.acceptedPaymentType, nil)
        XCTAssertEqual(preferances.charSet, "UTF-8")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let preferances = MerchantPreferances(
            setupFee: CurrencyCodeAmount(currency: .usd, value: 0),
            cancelURL: "https://example.com/agreements",
            returnURL: "https://example.com/agreements/latest",
            autoBill: .yes,
            initialFailAction: .continue,
            acceptedPaymentType: nil,
            charSet: "UTF-8"
        )
        
        let generated = try String(data: encoder.encode(preferances), encoding: .utf8)!
        let json =
            "{\"max_fail_attempts\":\"0\",\"char_set\":\"UTF-8\",\"initial_fail_amount_action\":\"CONTINUE\"," +
            "\"cancel_url\":\"https:\\/\\/example.com\\/agreements\",\"return_url\":\"https:\\/\\/example.com\\/agreements\\/latest\"," +
            "\"setup_fee\":{\"value\":\"0.00\",\"currency_code\":\"USD\"},\"auto_bill_amount\":\"YES\"}"
        
        // JSON is 434 characters long.
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
            "cancel_url": "https://example.com/agreements",
            "return_url": "https://example.com/agreements/latest",
            "max_fail_attempts": "0",
            "char_set": "UTF-8",
            "initial_fail_amount_action": "CONTINUE",
            "setup_fee": {
                "value": "0",
                "currency_code": "USD"
            },
            "auto_bill_amount": "YES"
        }
        """.data(using: .utf8)!
        let preferances = MerchantPreferances(
            setupFee: CurrencyCodeAmount(currency: .usd, value: 0),
            cancelURL: "https://example.com/agreements",
            returnURL: "https://example.com/agreements/latest",
            autoBill: .yes,
            initialFailAction: .continue,
            acceptedPaymentType: nil,
            charSet: "UTF-8"
        )
        
        try XCTAssertEqual(preferances, decoder.decode(MerchantPreferances.self, from: json))
    }
    
    public static var allTests: [(String, (MerchantPreferancesTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
