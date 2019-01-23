import XCTest
@testable import PayPal

final class SaleTests: XCTestCase {
    func testInit()throws {
        let sale = Sale(amount: DetailedAmount(currency: .usd, total: 10.00, details: nil), transaction: CurrencyAmount(currency: .usd, value: 1.00))
        
        XCTAssertNil(sale.id)
        XCTAssertNil(sale.status)
        XCTAssertNil(sale.created)
        XCTAssertNil(sale.updated)
        XCTAssertNil(sale.links)
        XCTAssertEqual(sale.transaction, CurrencyAmount(currency: .usd, value: 1.00))
        XCTAssertEqual(sale.amount, DetailedAmount(currency: .usd, total: 10.00, details: nil))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let sale = Sale(amount: DetailedAmount(currency: .usd, total: 10.00, details: nil), transaction: CurrencyAmount(currency: .usd, value: 1.00))
        let generated = try String(data: encoder.encode(sale), encoding: .utf8)!
        let json = "{\"amount\":{\"total\":\"10\",\"currency\":\"USD\"},\"transaction_fee\":{\"currency\":\"USD\",\"value\":\"1\"}}"
        
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
            "id": "259CEDEE-4A03-45A0-B088-B6A318544619",
            "amount": {
                "total": "10.00",
                "currency": "USD"
            },
            "transaction_fee": {
                "value": "1.00",
                "currency": "USD"
            },
            "status": "PENDING",
            "create_time": "2018-09-18T21:22:51+0000",
            "update_time": "2018-09-18T21:23:25+0000",
            "links": []
        }
        """.data(using: .utf8)!
        
        let sale = try decoder.decode(Sale.self, from: json)
        
        XCTAssertEqual(sale.id, "259CEDEE-4A03-45A0-B088-B6A318544619")
        XCTAssertEqual(sale.status, .pending)
        XCTAssertEqual(sale.created, Date(iso8601: "2018-09-18T21:22:51+0000"))
        XCTAssertEqual(sale.updated, Date(iso8601: "2018-09-18T21:23:25+0000"))
        XCTAssertEqual(sale.links, [])
        XCTAssertEqual(sale.transaction, CurrencyAmount(currency: .usd, value: 1.00))
        XCTAssertEqual(sale.amount, DetailedAmount(currency: .usd, total: 10.00, details: nil))
    }
    
    static var allTests: [(String, (SaleTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

