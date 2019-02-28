import XCTest
@testable import PayPal

public final class DetailedAmountDetailTests: XCTestCase {
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
        
        XCTAssertEqual(details.subtotal, 134.56)
        XCTAssertEqual(details.shipping, 5.69)
        XCTAssertEqual(details.tax, 13.45)
        XCTAssertEqual(details.handlingFee, 1.00)
        XCTAssertEqual(details.shippingDiscount, 5.69)
        XCTAssertEqual(details.insurance, 10.00)
        XCTAssertEqual(details.giftWrap, 2.50)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let details = DetailedAmount.Detail(
            subtotal: 134.567,
            shipping: 5.69,
            tax: 13.45,
            handlingFee: 1.003,
            shippingDiscount: 5.69,
            insurance: 10.006,
            giftWrap: 2.50
        )
        let generated = try String(data: encoder.encode(details), encoding: .utf8)!
        let json =
            "{\"handling_fee\":\"1\",\"subtotal\":\"134.57\",\"shipping_discount\":\"5.69\",\"insurance\":\"10.01\",\"tax\":\"13.45\"," +
            "\"gift_wrap\":\"2.5\",\"shipping\":\"5.69\"}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "gift_wrap": "2.50",
            "insurance": "10.00",
            "shipping_discount": "5.69",
            "handling_fee": "1.00",
            "tax": "13.45",
            "shipping": "5.69",
            "subtotal": "134.56"
        }
        """.data(using: .utf8)!
        
        let subtotal = """
        {
            "subtotal": "134.568"
        }
        """
        let shipping = """
        {
            "subtotal": "134.5",
            "shipping": "12345678.00"
        }
        """
        let tax = """
        {
            "subtotal": "134.5",
            "tax": "1,000.99"
        }
        """
        let handlingFee = """
        {
            "subtotal": "134.5",
            "handling_fee": "99.987"
        }
        """
        let shippingDiscount = """
        {
            "subtotal": "134.5",
            "shipping_discount": "90..56"
        }
        """
        let insurance = """
        {
            "subtotal": "134.5",
            "insurance": "$90.56"
        }
        """
        let giftWrap = """
        {
            "subtotal": "134.5",
            "gift_wrap": "9876543.210"
        }
        """
        
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: shipping))
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: tax))
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: shippingDiscount))
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: insurance))
        
        try XCTAssertEqual(
            decoder.decode(DetailedAmount.Detail.self, from: subtotal).subtotal,
            Decimal(sign: .plus, exponent: -2, significand: 13457)
        )
        try XCTAssertEqual(
            decoder.decode(DetailedAmount.Detail.self, from: giftWrap).giftWrap,
            Decimal(_exponent: -12, _length: 4, _isNegative: 0, _isCompact: 1, _reserved: 0, _mantissa: (41984, 43224, 34744, 35088, 0, 0, 0, 0))
        )
        try XCTAssertEqual(decoder.decode(DetailedAmount.Detail.self, from: handlingFee).handlingFee, 99.99)
        try XCTAssertEqual(decoder.decode(DetailedAmount.Detail.self, from: json), DetailedAmount.Detail(
            subtotal: 134.56,
            shipping: 5.69,
            tax: 13.45,
            handlingFee: 1.00,
            shippingDiscount: 5.69,
            insurance: 10.00,
            giftWrap: 2.50
        ))
    }
    
    public static var allTests: [(String, (DetailedAmountDetailTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




