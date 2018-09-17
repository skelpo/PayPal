import XCTest
@testable import PayPal

final class DetailedAmountDetailTests: XCTestCase {
    func testInit()throws {
        let details = try DetailedAmount.Detail(
            subtotal: "134.56",
            shipping: "5.69",
            tax: "13.45",
            handlingFee: "1.00",
            shippingDiscount: "5.69",
            insurance: "10.00",
            giftWrap: "2.50"
        )
        
        XCTAssertEqual(details.subtotal, "134.56")
        XCTAssertEqual(details.shipping, "5.69")
        XCTAssertEqual(details.tax, "13.45")
        XCTAssertEqual(details.handlingFee, "1.00")
        XCTAssertEqual(details.shippingDiscount, "5.69")
        XCTAssertEqual(details.insurance, "10.00")
        XCTAssertEqual(details.giftWrap, "2.50")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(DetailedAmount.Detail(subtotal: "134.568"))
        try XCTAssertThrowsError(DetailedAmount.Detail(subtotal: "134.56", shipping: "12345678.00"))
        try XCTAssertThrowsError(DetailedAmount.Detail(subtotal: "134.56", tax: "1,000.99"))
        try XCTAssertThrowsError(DetailedAmount.Detail(subtotal: "134.56", handlingFee: "99.987"))
        try XCTAssertThrowsError(DetailedAmount.Detail(subtotal: "134.56", shippingDiscount: "90..56"))
        try XCTAssertThrowsError(DetailedAmount.Detail(subtotal: "134.56", insurance: "$90.56"))
        try XCTAssertThrowsError(DetailedAmount.Detail(subtotal: "134.56", giftWrap: "9876543.210"))
        var details = try DetailedAmount.Detail(
            subtotal: "134.56",
            shipping: "5.69",
            tax: "13.45",
            handlingFee: "1.00",
            shippingDiscount: "5.69",
            insurance: "10.00",
            giftWrap: "2.50"
        )
        
        try XCTAssertThrowsError(details.set(\.subtotal <~ "134.568"))
        try XCTAssertThrowsError(details.set(\.shipping <~ "12345678.00"))
        try XCTAssertThrowsError(details.set(\.tax <~ "1,000.99"))
        try XCTAssertThrowsError(details.set(\.handlingFee <~ "99.987"))
        try XCTAssertThrowsError(details.set(\.shippingDiscount <~ "90..56"))
        try XCTAssertThrowsError(details.set(\.insurance <~ "$90.56"))
        try XCTAssertThrowsError(details.set(\.giftWrap <~ "9876543.210"))
        try details.set(\.subtotal <~ "134.56")
        try details.set(\.shipping <~ "1234567.00")
        try details.set(\.tax <~ "1000.99")
        try details.set(\.handlingFee <~ "99.98")
        try details.set(\.shippingDiscount <~ "90.56")
        try details.set(\.insurance <~ "90.56")
        try details.set(\.giftWrap <~ "9876543.21")
        
        XCTAssertEqual(details.subtotal, "134.56")
        XCTAssertEqual(details.shipping, "1234567.00")
        XCTAssertEqual(details.tax, "1000.99")
        XCTAssertEqual(details.handlingFee, "99.98")
        XCTAssertEqual(details.shippingDiscount, "90.56")
        XCTAssertEqual(details.insurance, "90.56")
        XCTAssertEqual(details.giftWrap, "9876543.21")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let details = try DetailedAmount.Detail(
            subtotal: "134.56",
            shipping: "5.69",
            tax: "13.45",
            handlingFee: "1.00",
            shippingDiscount: "5.69",
            insurance: "10.00",
            giftWrap: "2.50"
        )
        let generated = try String(data: encoder.encode(details), encoding: .utf8)!
        let json =
            "{\"handling_fee\":\"1.00\",\"subtotal\":\"134.56\",\"shipping_discount\":\"5.69\",\"insurance\":\"10.00\",\"tax\":\"13.45\"," +
            "\"gift_wrap\":\"2.50\",\"shipping\":\"5.69\"}"
        
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
        
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: subtotal))
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: shipping))
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: tax))
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: handlingFee))
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: shippingDiscount))
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: insurance))
        try XCTAssertThrowsError(decoder.decode(DetailedAmount.Detail.self, from: giftWrap))
        try XCTAssertEqual(decoder.decode(DetailedAmount.Detail.self, from: json), DetailedAmount.Detail(
            subtotal: "134.56",
            shipping: "5.69",
            tax: "13.45",
            handlingFee: "1.00",
            shippingDiscount: "5.69",
            insurance: "10.00",
            giftWrap: "2.50"
        ))
    }
    
    static var allTests: [(String, (DetailedAmountDetailTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




