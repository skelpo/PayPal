import XCTest
@testable import PayPal

public final class OrderTests: XCTestCase {
    func testInit()throws {
        let order = Order(
            intent: .sale,
            units: [],
            payment: Order.Payment(captures: nil, refunds: nil, sales: nil, authorizations: nil),
            total: CurrencyAmount(currency: .usd, value: 150.78),
            context: AppContext(),
            metadata: Order.Metadata(data: [:]),
            redirects: Redirects(return: "https://example.com/approved", cancel: "https://example.com/canceled")
        )
        
        XCTAssertEqual(order.intent, .sale)
        XCTAssertEqual(order.units, [])
        XCTAssertEqual(order.payment, Order.Payment(captures: nil, refunds: nil, sales: nil, authorizations: nil))
        XCTAssertEqual(order.metadata, Order.Metadata(data: [:]))
        XCTAssertEqual(order.redirects, Redirects(return: "https://example.com/approved", cancel: "https://example.com/canceled"))
        XCTAssertEqual(order.total, CurrencyAmount(currency: .usd, value: 150.78))
        XCTAssertEqual(order.context, AppContext())
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let order = Order(
            intent: .sale,
            units: [],
            payment: Order.Payment(captures: nil, refunds: nil, sales: nil, authorizations: nil),
            total: CurrencyAmount(currency: .usd, value: 150.78),
            context: AppContext(),
            metadata: Order.Metadata(data: [:]),
            redirects: Redirects(return: nil, cancel: nil)
        )
        
        let generated = try String(data: encoder.encode(order), encoding: .utf8)!
        let json =
            "{\"intent\":\"SALE\",\"redirect_urls\":{},\"payment_details\":{},\"purchase_units\":[],\"metadata\":{\"supplementary_data\":[]},\"application_context\":{},\"gross_total_amount\":{\"currency\":\"USD\",\"value\":\"150.78\"}}"
        
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
        let json = """
        {
            "id": "77083E30-667F-45B4-801A-5A4B177DE8EC",
            "redirect_urls": {},
            "metadata": {
                "supplementary_data": []
            },
            "application_context": {},
            "gross_total_amount": {
                "currency": "USD",
                "value": "150.78"
            },
            "payment_details": {},
            "purchase_units": [],
            "intent": "SALE",
            "status": "CREATED",
            "create_time": "2018-09-20T13:17:47+0000",
            "update_time": "2018-09-20T13:18:03+0000",
            "links": []
        }
        """.data(using: .utf8)!
        
        let order = try decoder.decode(Order.self, from: json)
        XCTAssertEqual(order.id, "77083E30-667F-45B4-801A-5A4B177DE8EC")
        XCTAssertEqual(order.intent, .sale)
        XCTAssertEqual(order.units, [])
        XCTAssertEqual(order.payment, Order.Payment(captures: nil, refunds: nil, sales: nil, authorizations: nil))
        XCTAssertEqual(order.metadata, Order.Metadata(data: [:]))
        XCTAssertEqual(order.redirects, Redirects(return: nil, cancel: nil))
        XCTAssertEqual(order.status, .created)
        XCTAssertEqual(order.created, Date(iso8601: "2018-09-20T13:17:47+0000"))
        XCTAssertEqual(order.updated, Date(iso8601: "2018-09-20T13:18:03+0000"))
        XCTAssertEqual(order.links, [])
        XCTAssertEqual(order.total, CurrencyAmount(currency: .usd, value: 150.78))
        XCTAssertEqual(order.context, AppContext())
    }
    
    static var allTests: [(String, (OrderTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





