import XCTest
@testable import PayPal

final class OfferTests: XCTestCase {
    func testInit()throws {
        let offer = try Offer(buyerAmount: Money(currency: .usd, value: "10.99"), sellerAmount: Money(currency: .usd, value: "10.99"), type: .refund)
        
        XCTAssertEqual(offer.type, .refund)
        try XCTAssertEqual(offer.sellerAmount, Money(currency: .usd, value: "10.99"))
        try XCTAssertEqual(offer.buyerAmount, Money(currency: .usd, value: "10.99"))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let offer = try Offer(buyerAmount: Money(currency: .usd, value: "10.99"), sellerAmount: Money(currency: .usd, value: "10.99"), type: .refund)
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
        let offer = try Offer(buyerAmount: Money(currency: .usd, value: "10.99"), sellerAmount: Money(currency: .usd, value: "10.99"), type: .refund)
        
        try XCTAssertEqual(decoder.decode(Offer.self, from: json), offer)
    }
    
    static var allTests: [(String, (OfferTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




