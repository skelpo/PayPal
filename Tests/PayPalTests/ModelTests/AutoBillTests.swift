import XCTest
@testable import PayPal

final class AutoBillTests: XCTestCase {
    struct Agreement: Codable {
        let auto: AutoBill
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(AutoBill.yes.rawValue, "YES")
        XCTAssertEqual(AutoBill.no.rawValue, "NO")
    }
    
    func testAllCase() {
        XCTAssertEqual(AutoBill.allCases.count, 2)
        XCTAssertEqual(AutoBill.allCases, [.no, .yes])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let yes = try String(data: encoder.encode(Agreement(auto: .yes)), encoding: .utf8)
        let no = try String(data: encoder.encode(Agreement(auto: .no)), encoding: .utf8)
        
        XCTAssertEqual(yes, "{\"auto\":\"YES\"}")
        XCTAssertEqual(no, "{\"auto\":\"NO\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let yes = """
        {
            "auto": "YES"
        }
        """.data(using: .utf8)!
        let no = """
        {
            "auto": "NO"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Agreement.self, from: yes).auto, .yes)
        try XCTAssertEqual(decoder.decode(Agreement.self, from: no).auto, .no)
    }
    
    static var allTests: [(String, (AutoBillTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



