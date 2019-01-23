import XCTest
@testable import PayPal

final class DetailedAmountTests: XCTestCase {
    func testInit()throws {
        let details = DetailedAmount.Detail(
            subtotal: 134.56,
            shipping: 5.69,
            tax: 13.45,
            handlingFee: 1.00,
            shippingDiscount: 5.69,
            insurance: 10.00,
            giftWrap: 2.50
        )
        let amount = DetailedAmount(currency: .usd, total: 172.89, details: details)

        
        XCTAssertEqual(amount.amount.currency, .usd)
        XCTAssertEqual(amount.amount.value, 172.89)
        XCTAssertEqual(amount.details, details)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let amount = DetailedAmount(currency: .usd, total: 172.89, details: .init(subtotal: 134.56))
        let generated = try String(data: encoder.encode(amount), encoding: .utf8)
        let json = "{\"total\":\"172.89\",\"currency\":\"USD\",\"details\":{\"subtotal\":\"134.56\"}}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "currency": "USD",
            "total": "172.89",
            "details": {
                "subtotal": "134.56"
            }
        }
        """.data(using: .utf8)!
        
        let amount = DetailedAmount(currency: .usd, total: 172.89, details: .init(subtotal: 134.56))
        try XCTAssertEqual(decoder.decode(DetailedAmount.self, from: json), amount)
    }
    
    static var allTests: [(String, (DetailedAmountTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





