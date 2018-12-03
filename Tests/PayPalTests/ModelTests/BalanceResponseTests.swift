import XCTest
@testable import PayPal

final class BalanceResponseTests: XCTestCase {
    func testDecoding()throws {
        let json = """
        {
            "payer_id": "12D54EFB-D12F-4AF8-B5BF-AC62FFE253CC",
            "available_balances": [
                {
                    "currency_code": "USD",
                    "value": "1000000.00"
                }
            ],
            "pending_balances": [
                {
                    "currency_code": "USD",
                    "value": "5000.00"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let response = try JSONDecoder().decode(BalanceResponse.self, from: json)
        XCTAssertEqual(response.payer, "12D54EFB-D12F-4AF8-B5BF-AC62FFE253CC")
        XCTAssertEqual(response.available, [CurrencyCodeAmount(currency: .usd, value: 1000000.00)])
        XCTAssertEqual(response.pending, [CurrencyCodeAmount(currency: .usd, value: 5000.00)])
    }
    
    static var allTests: [(String, (BalanceResponseTests) -> ()throws -> ())] = [
        ("testDecoding", testDecoding)
    ]
}
