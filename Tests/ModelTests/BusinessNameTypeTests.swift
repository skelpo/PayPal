import XCTest
@testable import PayPal

final class BusinessNameTypeTests: XCTestCase {
    struct BusiName: Codable {
        let type: Business.Name.NameType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Business.Name.NameType.legal.rawValue, "LEGAL")
        XCTAssertEqual(Business.Name.NameType.doingBusiness.rawValue, "DOING_BUSINESS_AS")
        XCTAssertEqual(Business.Name.NameType.stockTrading.rawValue, "STOCK_TRADING_NAME")
    }
    
    func testAllCase() {
        XCTAssertEqual(Business.Name.NameType.allCases.count, 3)
        XCTAssertEqual(Business.Name.NameType.allCases, [.legal, .doingBusiness, .stockTrading])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let doingBusiness = try String(data: encoder.encode(BusiName(type: .doingBusiness)), encoding: .utf8)
        let stockTrading = try String(data: encoder.encode(BusiName(type: .stockTrading)), encoding: .utf8)
        
        XCTAssertEqual(doingBusiness, "{\"type\":\"DOING_BUSINESS_AS\"}")
        XCTAssertEqual(stockTrading, "{\"type\":\"STOCK_TRADING_NAME\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let doingBusiness = """
        {
            "type": "DOING_BUSINESS_AS"
        }
        """.data(using: .utf8)!
        let stockTrading = """
        {
            "type": "STOCK_TRADING_NAME"
        }
        """
        
        try XCTAssertEqual(decoder.decode(BusiName.self, from: doingBusiness).type, .doingBusiness)
        try XCTAssertEqual(decoder.decode(BusiName.self, from: stockTrading).type, .stockTrading)
    }
    
    static var allTests: [(String, (BusinessNameTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

