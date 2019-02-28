import XCTest
@testable import PayPal

public final class TemplateSettingFieldTests: XCTestCase {
    struct Settings: Codable {
        let field: Template.Settings.Field
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Template.Settings.Field.itemsQuantity.rawValue, "items.quantity")
        XCTAssertEqual(Template.Settings.Field.itemsDescription.rawValue, "items.description")
        XCTAssertEqual(Template.Settings.Field.itemsDate.rawValue, "items.date")
        XCTAssertEqual(Template.Settings.Field.itemsDiscount.rawValue, "items.discount")
        XCTAssertEqual(Template.Settings.Field.itemsTax.rawValue, "items.tax")
        XCTAssertEqual(Template.Settings.Field.discount.rawValue, "discount")
        XCTAssertEqual(Template.Settings.Field.shipping.rawValue, "shipping")
        XCTAssertEqual(Template.Settings.Field.custom.rawValue, "custom")
    }
    
    func testAllCase() {
        XCTAssertEqual(Template.Settings.Field.allCases.count, 8)
        XCTAssertEqual(Template.Settings.Field.allCases, [.itemsQuantity, .itemsDescription, .itemsDate, .itemsDiscount, .itemsTax, .discount, .shipping, .custom])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let itemsQuantity = try String(data: encoder.encode(Settings(field: .itemsQuantity)), encoding: .utf8)
        let itemsDiscount = try String(data: encoder.encode(Settings(field: .itemsDiscount)), encoding: .utf8)
        
        XCTAssertEqual(itemsQuantity, "{\"field\":\"items.quantity\"}")
        XCTAssertEqual(itemsDiscount, "{\"field\":\"items.discount\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let discount = """
        {
            "field": "discount"
        }
        """.data(using: .utf8)!
        let custom = """
        {
            "field": "custom"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Settings.self, from: discount).field, .discount)
        try XCTAssertEqual(decoder.decode(Settings.self, from: custom).field, .custom)
    }
    
    static var allTests: [(String, (TemplateSettingFieldTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




