import XCTest
@testable import PayPal

final class InvoiceMeasureTests: XCTestCase {
    struct Inv: Codable {
        let measure: Invoice.Measure
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Invoice.Measure.quantity.rawValue, "QUANTITY")
        XCTAssertEqual(Invoice.Measure.hours.rawValue, "HOURS")
        XCTAssertEqual(Invoice.Measure.amount.rawValue, "AMOUNT")
    }
    
    func testAllCase() {
        XCTAssertEqual(Invoice.Measure.allCases.count, 3)
        XCTAssertEqual(Invoice.Measure.allCases, [.quantity, .hours, .amount])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let quantity = try String(data: encoder.encode(Inv(measure: .quantity)), encoding: .utf8)
        let hours = try String(data: encoder.encode(Inv(measure: .hours)), encoding: .utf8)
        
        XCTAssertEqual(quantity, "{\"measure\":\"QUANTITY\"}")
        XCTAssertEqual(hours, "{\"measure\":\"HOURS\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let amount = """
        {
            "measure": "AMOUNT"
        }
        """.data(using: .utf8)!
        let quantity = """
        {
            "measure": "QUANTITY"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Inv.self, from: amount).measure, .amount)
        try XCTAssertEqual(decoder.decode(Inv.self, from: quantity).measure, .quantity)
    }
    
    static var allTests: [(String, (InvoiceMeasureTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



