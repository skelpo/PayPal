import XCTest
@testable import PayPal

public final class DesignationTests: XCTestCase {
    func testInit()throws {
        let designation = Business.Designation(title: "CTO", area: "Software Engineering")
        
        XCTAssertEqual(designation.title, "CTO")
        XCTAssertEqual(designation.area, "Software Engineering")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let designation = Business.Designation(title: "CTO", area: "Software Engineering")
        let json = try String(data: encoder.encode(designation), encoding: .utf8)!
        let generated = "{\"title\":\"CTO\",\"business_area\":\"Software Engineering\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "title": "CTO",
            "business_area": "Software Engineering"
        }
        """.data(using: .utf8)!
        
        let designation = Business.Designation(title: "CTO", area: "Software Engineering")
        try XCTAssertEqual(designation, decoder.decode(Business.Designation.self, from: json))
    }
    
    public static var allTests: [(String, (DesignationTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

