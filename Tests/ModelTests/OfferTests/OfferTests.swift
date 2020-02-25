import XCTest
@testable import PayPal

public final class OfferTests: XCTestCase {
    func testInit()throws {
        let offer = Offer(buyerAmount: CurrencyCodeAmount(currency: .usd, value: 10.99), sellerAmount: CurrencyCodeAmount(currency: .usd, value: 10.99), type: .refund)
        
        XCTAssertEqual(offer.type, .refund)
        XCTAssertEqual(offer.sellerAmount, CurrencyCodeAmount(currency: .usd, value: 10.99))
        XCTAssertEqual(offer.buyerAmount, CurrencyCodeAmount(currency: .usd, value: 10.99))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let offer = Offer(buyerAmount: CurrencyCodeAmount(currency: .usd, value: 10.99), sellerAmount: CurrencyCodeAmount(currency: .usd, value: 10.99), type: .refund)
        let generated = try String(data: encoder.encode(offer), encoding: .utf8)
        let json =
            "{\"offer_type\":\"REFUND\",\"buyer_requested_amount\":{\"value\":\"10.99\",\"currency_code\":\"USD\"}," +
            "\"seller_offered_amount\":{\"value\":\"10.99\",\"currency_code\":\"USD\"}}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "offer_type": "REFUND",
            "seller_offered_amount": {
                "value": "10.99",
                "currency_code": "USD"
            },
            "buyer_requested_amount": {
                "value": "10.99",
                "currency_code": "USD"
            }
        }
        """.data(using: .utf8)!
        let offer = Offer(buyerAmount: CurrencyCodeAmount(currency: .usd, value: 10.99), sellerAmount: CurrencyCodeAmount(currency: .usd, value: 10.99), type: .refund)
        
        try XCTAssertEqual(decoder.decode(Offer.self, from: json), offer)
    }
    
    public static var allTests: [(String, (OfferTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




