import XCTest
@testable import PayPal

final class AppContextTests: XCTestCase {
    func testInit()throws {
        let context = try AppContext(
            brand: "Example Inc.",
            locale: "us-AZ",
            landingPage: "Login",
            shipping: .buyer,
            userAction: "Continue",
            data: [:]
        )
        
        XCTAssertEqual(context.brand, "Example Inc.")
        XCTAssertEqual(context.locale, "us-AZ")
        XCTAssertEqual(context.landingPage, "Login")
        XCTAssertEqual(context.shipping, .buyer)
        XCTAssertEqual(context.data, [:])
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(AppContext(brand: String(repeating: "b", count: 128)))
        try XCTAssertThrowsError(AppContext(locale: "US"))
        var context = try AppContext(brand: "Example Inc.", locale: "us-AZ")
        
        try XCTAssertThrowsError(context.set(\AppContext.brand <~ String(repeating: "b", count: 128)))
        try XCTAssertThrowsError(context.set(\.locale <~ "US"))
        try context.set(\AppContext.brand <~ String(repeating: "b", count: 127))
        try context.set(\.locale <~ "us")
        
        XCTAssertEqual(context.brand, String(repeating: "b", count: 127))
        XCTAssertEqual(context.locale, "us")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let context = try AppContext(
            brand: "Example Inc.",
            locale: "us-AZ",
            landingPage: "Login",
            shipping: .buyer,
            userAction: "Continue",
            data: [:]
        )
        let generated = try String(data: encoder.encode(context), encoding: .utf8)!
        let json =
            "{\"locale\":\"us-AZ\",\"landing_page\":\"Login\",\"shipping_preference\":\"GET_FROM_FILE\",\"supplementary_data\":[]," +
            "\"brand_name\":\"Example Inc.\",\"user_action\":\"Continue\"}"
        
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
            "supplementary_data": [],
            "user_action": "Continue",
            "shipping_preference": "GET_FROM_FILE",
            "landing_page": "Login",
            "locale": "us-AZ",
            "brand_name": "Example Inc."
        }
        """.data(using: .utf8)!
        let locale = """
        {
            "locale": "US"
        }
        """.data(using: .utf8)!
        let brand = """
        {
            "brand_name": "\(String(repeating: "b", count: 128))"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(AppContext.self, from: locale))
        try XCTAssertThrowsError(decoder.decode(AppContext.self, from: brand))
        try XCTAssertEqual(decoder.decode(AppContext.self, from: json), AppContext(
            brand: "Example Inc.",
            locale: "us-AZ",
            landingPage: "Login",
            shipping: .buyer,
            userAction: "Continue",
            data: [:]
        ))
    }
    
    static var allTests: [(String, (AppContextTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




