import XCTest
@testable import PayPal

final class OrderPaymentTests: XCTestCase {
    func testInit()throws {
        let payment = Order.Payment(
            captures: [Capture(amount: nil, transaction: nil)],
            refunds: [Refund(amount: nil)],
            sales: [Sale(amount: nil, transaction: CurrencyAmount(currency: .usd, value: 1.00))],
            authorizations: [Sale(amount: nil, transaction: CurrencyAmount(currency: .usd, value: 2.00))]
        )
        
        XCTAssertEqual(payment.captures, [Capture(amount: nil, transaction: nil)])
        XCTAssertEqual(payment.refunds, [Refund(amount: nil)])
        XCTAssertEqual(payment.sales, [Sale(amount: nil, transaction: CurrencyAmount(currency: .usd, value: 1.00))])
        XCTAssertEqual(payment.authorizations, [Sale(amount: nil, transaction: CurrencyAmount(currency: .usd, value: 2.00))])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let payment = Order.Payment(captures: [], refunds: [], sales: [], authorizations: [])
        let generated = try String(data: encoder.encode(payment), encoding: .utf8)!
        let json = "{\"refunds\":[],\"authorizations\":[],\"sales\":[],\"captures\":[]}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "captures": [],
            "refunds": [],
            "sales": [],
            "authorizations": []
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Order.Payment.self, from: json), Order.Payment(captures: [], refunds: [], sales: [], authorizations: []))
    }
    
    static var allTests: [(String, (OrderPaymentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


