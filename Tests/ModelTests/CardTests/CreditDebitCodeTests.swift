import XCTest
@testable import PayPal

public final class CreditDebitCodeTests: XCTestCase {
    struct Card: Codable {
        let code: CreditDebitCode
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(CreditDebitCode.credit.rawValue, "CREDIT")
        XCTAssertEqual(CreditDebitCode.debit.rawValue, "DEBIT")
        XCTAssertEqual(CreditDebitCode.all.rawValue, "ALL")
    }
    
    func testAllCase() {
        XCTAssertEqual(CreditDebitCode.allCases.count, 3)
        XCTAssertEqual(CreditDebitCode.allCases, [.credit, .debit, .all])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let debit = try String(data: encoder.encode(Card(code: .debit)), encoding: .utf8)
        let all = try String(data: encoder.encode(Card(code: .all)), encoding: .utf8)
        
        XCTAssertEqual(debit, "{\"code\":\"DEBIT\"}")
        XCTAssertEqual(all, "{\"code\":\"ALL\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let credit = """
        {
            "code": "CREDIT"
        }
        """.data(using: .utf8)!
        let all = """
        {
            "code": "ALL"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Card.self, from: credit).code, .credit)
        try XCTAssertEqual(decoder.decode(Card.self, from: all).code, .all)
    }
    
    public static var allTests: [(String, (CreditDebitCodeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
