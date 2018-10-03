import XCTest
@testable import PayPal

final class ChargeTypeTests: XCTestCase {
    struct Model: Codable {
        let type: ChargeType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(ChargeType.tax.rawValue, "TAX")
        XCTAssertEqual(ChargeType.shipping.rawValue, "SHIPPING")
    }
    
    func testAllCase() {
        XCTAssertEqual(ChargeType.allCases.count, 2)
        XCTAssertEqual(ChargeType.allCases, [.tax, .shipping])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let tax = try String(data: encoder.encode(Model(type: .tax)), encoding: .utf8)
        let ship = try String(data: encoder.encode(Model(type: .shipping)), encoding: .utf8)
        
        XCTAssertEqual(tax, "{\"type\":\"TAX\"}")
        XCTAssertEqual(ship, "{\"type\":\"SHIPPING\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let tax = """
        {
            "type": "TAX"
        }
        """.data(using: .utf8)!
        let ship = """
        {
            "type": "SHIPPING"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Model.self, from: tax).type, .tax)
        try XCTAssertEqual(decoder.decode(Model.self, from: ship).type, .shipping)
    }
    
    static var allTests: [(String, (ChargeTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




