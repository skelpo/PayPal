import XCTest
@testable import PayPal

fileprivate typealias Method = Payment.Transaction.PaymentMethod

final class PaymentTransactionPaymentMethodTests: XCTestCase {
    private struct Transaction: Codable {
        let method: Method
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Method.unrestricted.rawValue, "UNRESTRICTED")
        XCTAssertEqual(Method.instantFunding.rawValue, "INSTANT_FUNDING_SOURCE")
        XCTAssertEqual(Method.immediate.rawValue, "IMMEDIATE_PAY")
    }
    
    func testAllCase() {
        XCTAssertEqual(Method.allCases.count, 3)
        XCTAssertEqual(Method.allCases, [.unrestricted, .instantFunding, .immediate])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let unrestricted = try String(data: encoder.encode(Transaction(method: .unrestricted)), encoding: .utf8)
        let instantFunding = try String(data: encoder.encode(Transaction(method: .instantFunding)), encoding: .utf8)
        
        XCTAssertEqual(unrestricted, "{\"method\":\"UNRESTRICTED\"}")
        XCTAssertEqual(instantFunding, "{\"method\":\"INSTANT_FUNDING_SOURCE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let immediate = """
        {
            "method": "IMMEDIATE_PAY"
        }
        """.data(using: .utf8)!
        let unrestricted = """
        {
            "method": "UNRESTRICTED"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Transaction.self, from: immediate).method, .immediate)
        try XCTAssertEqual(decoder.decode(Transaction.self, from: unrestricted).method, .unrestricted)
    }
    
    static var allTests: [(String, (PaymentTransactionPaymentMethodTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
