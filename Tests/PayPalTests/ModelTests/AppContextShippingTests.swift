import XCTest
@testable import PayPal

typealias AppShipping = AppContext.Shipping

final class AppContextShippingTests: XCTestCase {
    struct App: Codable {
        let shipping: AppShipping
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(AppShipping.none.rawValue, "NO_SHIPPING")
        XCTAssertEqual(AppShipping.buyer.rawValue, "GET_FROM_FILE")
        XCTAssertEqual(AppShipping.merchant.rawValue, "SET_PROVIDED_ADDRESS")
    }
    
    func testAllCase() {
        XCTAssertEqual(AppShipping.allCases.count, 3)
        XCTAssertEqual(AppShipping.allCases, [.none, .buyer, .merchant])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let none = try String(data: encoder.encode(App(shipping: .none)), encoding: .utf8)
        let buyer = try String(data: encoder.encode(App(shipping: .buyer)), encoding: .utf8)
        
        XCTAssertEqual(none, "{\"shipping\":\"NO_SHIPPING\"}")
        XCTAssertEqual(buyer, "{\"shipping\":\"GET_FROM_FILE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let merchant = """
        {
            "shipping": "SET_PROVIDED_ADDRESS"
        }
        """.data(using: .utf8)!
        let none = """
        {
            "shipping": "NO_SHIPPING"
        }
        """
        
        try XCTAssertEqual(decoder.decode(App.self, from: merchant).shipping, .merchant)
        try XCTAssertEqual(decoder.decode(App.self, from: none).shipping, .none)
    }
    
    static var allTests: [(String, (AppContextShippingTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




