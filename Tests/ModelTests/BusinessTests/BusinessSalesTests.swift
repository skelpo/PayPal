import XCTest
import Failable
@testable import PayPal

public final class BusinessSalesTests: XCTestCase {
    func testInit()throws {
        let sales = try Business.Sales(
            price: MoneyRange(50...60, currency: .usd),
            volume: MoneyRange(50...60, currency: .usd),
            venues: [],
            website: .init("https://nameless.io"),
            online: PercentRange(0...1)
        )
        
        XCTAssertEqual(sales.price, MoneyRange(50...60, currency: .usd))
        XCTAssertEqual(sales.volume, MoneyRange(50...60, currency: .usd))
        XCTAssertEqual(sales.venues, [])
        XCTAssertEqual(sales.website.value, "https://nameless.io")
        try XCTAssertEqual(sales.online, PercentRange(0...1))
    }
    
    func testValueValidation()throws {
        var sales = try Business.Sales(
            price: MoneyRange(50...60, currency: .usd),
            volume: MoneyRange(50...60, currency: .usd),
            venues: [],
            website: .init("https://nameless.io"),
            online: PercentRange(0...1)
        )
        
        try XCTAssertThrowsError(sales.website <~ String(repeating: "w", count: 256))
        try sales.website <~ String(repeating: "w", count: 255)
        
        XCTAssertEqual(sales.website.value, String(repeating: "w", count: 255))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let sales = try Business.Sales(
            price: MoneyRange(50...60, currency: .usd),
            volume: MoneyRange(50...60, currency: .usd),
            venues: [],
            website: .init("https://nameless.io"),
            online: PercentRange(0...1)
        )
        
        let generated = try String(data: encoder.encode(sales), encoding: .utf8)!
        let json =
            "{\"sales_venues\":[],\"revenue_from_online_sales\":{\"maximum_percent\":1,\"minimum_percent\":0}," +
            "\"average_price\":{\"minimum_amount\":{\"value\":\"50\",\"currency_code\":\"USD\"}," +
            "\"maximum_amount\":{\"value\":\"60\",\"currency_code\":\"USD\"}},\"website\":\"https:\\/\\/nameless.io\"," +
            "\"average_monthly_volume\":{\"minimum_amount\":{\"value\":\"50\",\"currency_code\":\"USD\"}," +
            "\"maximum_amount\":{\"value\":\"60\",\"currency_code\":\"USD\"}}}"
        
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
            "sales_venues": [],
            "revenue_from_online_sales": {
                "maximum_percent": 1,
                "minimum_percent": 0
            },
            "average_price": {
                "minimum_amount": {
                    "value": "50",
                    "currency_code": "USD"
                },
                "maximum_amount": {
                    "value": "60",
                    "currency_code": "USD"
                }
            },
            "website": "https://nameless.io",
            "average_monthly_volume": {
                "minimum_amount": {
                    "value": "50",
                    "currency_code": "USD"
                },
                "maximum_amount": {
                    "value": "60",
                    "currency_code": "USD"
                }
            }
        }
        """.data(using: .utf8)!
        
        
        let sales = try Business.Sales(
            price: MoneyRange(50...60, currency: .usd),
            volume: MoneyRange(50...60, currency: .usd),
            venues: [],
            website: .init("https://nameless.io"),
            online: PercentRange(0...1)
        )
        try XCTAssertEqual(sales, decoder.decode(Business.Sales.self, from: json))
    }
    
    public static var allTests: [(String, (BusinessSalesTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


