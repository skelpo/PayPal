import XCTest
@testable import PayPal

public final class PartnerFeeTests: XCTestCase {
    func testInit()throws {
        let amount = CurrencyAmount(currency: .usd, value: 54.96)
        let payee = Payee(email: nil, merchant: nil, metadata: nil)
        let fee = PartnerFee(receiver: payee, amount: amount)
        
        XCTAssertEqual(fee.receiver, payee)
        XCTAssertEqual(fee.amount, amount)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let fee = PartnerFee(
            receiver: Payee(email: nil, merchant: nil, metadata: nil),
            amount: CurrencyAmount(currency: .usd, value: 54.96)
        )
        let generated = try String(data: encoder.encode(fee), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"amount\":{\"currency\":\"USD\",\"value\":\"54.96\"},\"receiver\":{}}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "receiver": {},
            "amount": {
                "currency": "USD",
                "value": "54.96"
            }
        }
        """.data(using: .utf8)!
        
        let fee = PartnerFee(
            receiver: Payee(email: nil, merchant: nil, metadata: nil),
            amount: CurrencyAmount(currency: .usd, value: 54.96)
        )
        try XCTAssertEqual(fee, decoder.decode(PartnerFee.self, from: json))
    }
    
    public static var allTests: [(String, (PartnerFeeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


