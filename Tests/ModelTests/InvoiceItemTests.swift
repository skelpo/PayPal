import XCTest
import Failable
@testable import PayPal

final class InvoiceItemTests: XCTestCase {
    let now = Date()
    
    func testInit()throws {
        let item = try Invoice.Item(
            name: "Widget",
            description: .init("Round and white, like a ping-pong ball"),
            quantity: 3,
            unitPrice: .init(CurrencyAmount(currency: .usd, value: 50)),
            tax: Tax(name: "Sales", percent: 10, amount: CurrencyAmount(currency: .usd, value: 5.00)),
            date: self.now,
            discount: nil,
            unitMeasure: .quantity
        )
        
        XCTAssertNil(item.discount)
        XCTAssertEqual(item.name, "Widget")
        XCTAssertEqual(item.description.value, "Round and white, like a ping-pong ball")
        XCTAssertEqual(item.quantity, 3)
        XCTAssertEqual(item.date, self.now)
        XCTAssertEqual(item.unitMeasure, .quantity)
        XCTAssertEqual(item.unitPrice.value, CurrencyAmount(currency: .usd, value: 50))
        XCTAssertEqual(item.tax, Tax(name: "Sales", percent: 10, amount: CurrencyAmount(currency: .usd, value: 5.00)))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Invoice.Item(
            name: .init(String(repeating: "n", count: 201)),
            description: .init("Round and white, like a ping-pong ball"),
            quantity: .init(3),
            unitPrice: .init(CurrencyAmount(currency: .usd, value: 50)),
            tax: nil,
            date: nil,
            discount: nil,
            unitMeasure: nil
        ))
        try XCTAssertThrowsError(Invoice.Item(
            name: "Widget",
            description: .init(String(repeating: "d", count: 1001)),
            quantity: .init(3),
            unitPrice: .init(CurrencyAmount(currency: .usd, value: 50)),
            tax: nil,
            date: nil,
            discount: nil,
            unitMeasure: nil
        ))
        try XCTAssertThrowsError(Invoice.Item(
            name: "Widget",
            description: .init("Round and white, like a ping-pong ball"),
            quantity: .init(-10_001),
            unitPrice: .init(CurrencyAmount(currency: .usd, value: 50)),
            tax: nil,
            date: nil,
            discount: nil,
            unitMeasure: nil
        ))
        try XCTAssertThrowsError(Invoice.Item(
            name: "Widget",
            description: .init("Round and white, like a ping-pong ball"),
            quantity: .init(3),
            unitPrice: .init(CurrencyAmount(currency: .usd, value: 1000001)),
            tax: nil,
            date: nil,
            discount: nil,
            unitMeasure: nil
        ))
        
        var item = try Invoice.Item(
            name: "Widget",
            description: .init("Round and white, like a ping-pong ball"),
            quantity: .init(3),
            unitPrice: .init(CurrencyAmount(currency: .usd, value: 50)),
            tax: Tax(name: "Sales", percent: 10, amount: CurrencyAmount(currency: .usd, value: 5.00)),
            date: self.now,
            discount: nil,
            unitMeasure: .quantity
        )
        
        try XCTAssertThrowsError(item.name <~ String(repeating: "n", count: 201))
        try XCTAssertThrowsError(item.description <~ String(repeating: "d", count: 1001))
        try XCTAssertThrowsError(item.quantity <~ -10_001)
        try XCTAssertThrowsError(item.unitPrice <~ CurrencyAmount(currency: .usd, value: 1000001))
        try item.name <~ String(repeating: "n", count: 200)
        try item.description <~ String(repeating: "d", count: 1000)
        try item.quantity <~ -10_000
        try item.unitPrice <~ CurrencyAmount(currency: .usd, value: 50)
        
        XCTAssertEqual(item.name.value, String(repeating: "n", count: 200))
        XCTAssertEqual(item.description.value, String(repeating: "d", count: 1000))
        XCTAssertEqual(item.quantity.value, -10_000)
        XCTAssertEqual(item.unitPrice.value, CurrencyAmount(currency: .usd, value: 50))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let item = try Invoice.Item(
            name: "Widget",
            description: .init("Round and white, like a ping-pong ball"),
            quantity: 3,
            unitPrice: .init(CurrencyAmount(currency: .usd, value: 50)),
            tax: nil,
            date: self.now,
            discount: nil,
            unitMeasure: .quantity
        )
        let generated = try String(data: encoder.encode(item), encoding: .utf8)!
        let json =
            "{\"quantity\":3,\"unit_price\":{\"currency\":\"USD\",\"value\":\"50\"},\"unit_of_measure\":\"QUANTITY\",\"name\":\"Widget\"," +
            "\"description\":\"Round and white, like a ping-pong ball\",\"date\":\"\(self.now.iso8601)\"}"
        
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
        let item = try Invoice.Item(
            name: "Widget",
            description: .init("Round and white, like a ping-pong ball"),
            quantity: 3,
            unitPrice: .init(CurrencyAmount(currency: .usd, value: 50)),
            tax: nil,
            date: self.now,
            discount: nil,
            unitMeasure: .quantity
        )
        
        let json = """
        {
            "unit_of_measure": "QUANTITY",
            "date": "\(self.now.iso8601)",
            "unit_price": {
                "currency": "USD",
                "value": "50"
            },
            "quantity": 3,
            "description": "Round and white, like a ping-pong ball",
            "name": "Widget"
        }
        """.data(using: .utf8)!
        let nameFail = """
        {
            "unit_of_measure": "QUANTITY",
            "date": "\(self.now.iso8601)",
            "unit_price": {
                "currency": "USD",
                "value": "50"
            },
            "quantity": 3,
            "description": "Round and white, like a ping-pong ball",
            "name": "\(String(repeating: "n", count: 201))"
        }
        """.data(using: .utf8)!
        let descriptionFail = """
        {
            "unit_of_measure": "QUANTITY",
            "date": "\(self.now.iso8601)",
            "unit_price": {
                "currency": "USD",
                "value": "50"
            },
            "quantity": 3,
            "description": "\(String(repeating: "d", count: 1001))",
            "name": "Widget"
        }
        """.data(using: .utf8)!
        let quantityFail = """
        {
            "unit_of_measure": "QUANTITY",
            "date": "\(self.now.iso8601)",
            "unit_price": {
                "currency": "USD",
                "value": "50"
            },
            "quantity": -10001,
            "description": "Round and white, like a ping-pong ball",
            "name": "Widget"
        }
        """.data(using: .utf8)!
        let currencyFail = """
        {
            "unit_of_measure": "QUANTITY",
            "date": "\(self.now.iso8601)",
            "unit_price": {
                "currency": "USD",
                "value": "1000001"
            },
            "quantity": 3,
            "description": "Round and white, like a ping-pong ball",
            "name": "Widget"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(Invoice.Item.self, from: nameFail))
        try XCTAssertThrowsError(decoder.decode(Invoice.Item.self, from: descriptionFail))
        try XCTAssertThrowsError(decoder.decode(Invoice.Item.self, from: quantityFail))
        try XCTAssertThrowsError(decoder.decode(Invoice.Item.self, from: currencyFail))
        try XCTAssertEqual(item, decoder.decode(Invoice.Item.self, from: json))
    }
    
    static var allTests: [(String, (InvoiceItemTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



