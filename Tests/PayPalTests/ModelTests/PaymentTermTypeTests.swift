import XCTest
@testable import PayPal

final class PaymentTermTypeTests: XCTestCase {
    struct User: Codable {
        let role: Role
    }
    
    struct Term: Codable {
        let type: PaymentTerm.TermType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(PaymentTerm.TermType.dueOnReceipt.rawValue, "DUE_ON_RECEIPT")
        XCTAssertEqual(PaymentTerm.TermType.dueDate.rawValue, "DUE_ON_DATE_SPECIFIED")
        XCTAssertEqual(PaymentTerm.TermType.net10.rawValue, "NET_10")
        XCTAssertEqual(PaymentTerm.TermType.net15.rawValue, "NET_15")
        XCTAssertEqual(PaymentTerm.TermType.net30.rawValue, "NET_30")
        XCTAssertEqual(PaymentTerm.TermType.net45.rawValue, "NET_45")
        XCTAssertEqual(PaymentTerm.TermType.net60.rawValue, "NET_60")
        XCTAssertEqual(PaymentTerm.TermType.net90.rawValue, "NET_90")
        XCTAssertEqual(PaymentTerm.TermType.noDueDate.rawValue, "NO_DUE_DATE")
    }
    
    func testAllCase() {
        XCTAssertEqual(PaymentTerm.TermType.allCases.count, 9)
        XCTAssertEqual(PaymentTerm.TermType.allCases, [.dueOnReceipt, .dueDate, .net10, .net15, .net30, .net45, .net60, .net90, .noDueDate])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let dueOnReceipt = try String(data: encoder.encode(Term(type: .dueOnReceipt)), encoding: .utf8)
        let dueDate = try String(data: encoder.encode(Term(type: .dueDate)), encoding: .utf8)
        
        XCTAssertEqual(dueOnReceipt, "{\"type\":\"DUE_ON_RECEIPT\"}")
        XCTAssertEqual(dueDate, "{\"type\":\"DUE_ON_DATE_SPECIFIED\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let net90 = """
        {
            "type": "NET_90"
        }
        """.data(using: .utf8)!
        let noDueDate = """
        {
            "type": "NO_DUE_DATE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Term.self, from: net90).type, .net90)
        try XCTAssertEqual(decoder.decode(Term.self, from: noDueDate).type, .noDueDate)
    }
    
    static var allTests: [(String, (PaymentTermTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
