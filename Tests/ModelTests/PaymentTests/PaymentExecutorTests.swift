import XCTest
@testable import PayPal

final class PaymentExecutorTests: XCTestCase {
    func testInit()throws {
        let executor = Payment.Executor(payer: "payer", amounts: [])
        
        XCTAssertEqual(executor.payer, "payer")
        XCTAssertEqual(executor.amounts, [])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let executor = Payment.Executor(payer: "payer", amounts: [DetailedAmount(currency: .usd, total: 10.00, details: nil)])
        let generated = try String(data: encoder.encode(executor), encoding: .utf8)!
        let json = "{\"payer_id\":\"payer\",\"transactions\":[{\"amount\":{\"currency\":\"USD\",\"total\":\"10.00\"}}]}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "payer_id": "payer",
            "transactions": [
                {
                    "amount": {
                        "currency": "USD",
                        "total": "10.00"
                    }
                }
            ]
        }
        """.data(using: .utf8)!
        
        let executor = Payment.Executor(payer: "payer", amounts: [DetailedAmount(currency: .usd, total: 10.00, details: nil)])
        try XCTAssertEqual(executor, decoder.decode(Payment.Executor.self, from: json))
    }
    
    static var allTests: [(String, (PaymentExecutorTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






