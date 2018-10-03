import XCTest
@testable import PayPal

final class TaxTests: XCTestCase {
    func testInit()throws {
        let tax = try Tax(name: "Sales", percent: 10, amount: Amount(currency: .usd, value: "0.59"))
        
        XCTAssertEqual(tax.name, "Sales")
        XCTAssertEqual(tax.percent, 10)
        try XCTAssertEqual(tax.amount, Amount(currency: .usd, value: "0.59"))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Tax(name: "Sales", percent: -1, amount: nil))
        try XCTAssertThrowsError(Tax(name: "Sales", percent: 101, amount: nil))
        try XCTAssertThrowsError(Tax(name: String(repeating: "n", count: 101), percent: 10, amount: nil))
        var tax = try Tax(name: "Sales", percent: 10, amount: nil)
        
        try XCTAssertThrowsError(tax.set(\.name <~ String(repeating: "n", count: 101)))
        try XCTAssertThrowsError(tax.set(\.percent <~ 200))
        try tax.set(\.name <~ "Federal")
        try tax.set(\.percent <~ 35)
        
        XCTAssertEqual(tax.name, "Federal")
        XCTAssertEqual(tax.percent, 35)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(Tax(name: "Sales", percent: 10, amount: nil)), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"name\":\"Sales\",\"percent\":10}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "name": "Sales",
            "percent": 10
        }
        """.data(using: .utf8)!
        let nameFail = """
        {
            "name": "\(String(repeating: "n", count: 101))",
            "percent": 10
        }
        """.data(using: .utf8)!
        let percentFail = """
        {
            "name": "Sales",
            "percent": 101
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(Tax.self, from: nameFail))
        try XCTAssertThrowsError(decoder.decode(Tax.self, from: percentFail))
        try XCTAssertEqual(Tax(name: "Sales", percent: 10, amount: nil), decoder.decode(Tax.self, from: json))
    }
    
    static var allTests: [(String, (TaxTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





