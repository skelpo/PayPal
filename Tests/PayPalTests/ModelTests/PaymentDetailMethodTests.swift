import XCTest
@testable import PayPal

final class PaymentDetailMethodTests: XCTestCase {
    struct Detail: Codable {
        let method: PaymentDetail.Method
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(PaymentDetail.Method.bankTransfer.rawValue, "BANK_TRANSFER")
        XCTAssertEqual(PaymentDetail.Method.cash.rawValue, "CASH")
        XCTAssertEqual(PaymentDetail.Method.check.rawValue, "CHECK")
        XCTAssertEqual(PaymentDetail.Method.creditCard.rawValue, "CREDIT_CARD")
        XCTAssertEqual(PaymentDetail.Method.debitCard.rawValue, "DEBIT_CARD")
        XCTAssertEqual(PaymentDetail.Method.paypal.rawValue, "PAYPAL")
        XCTAssertEqual(PaymentDetail.Method.wireTransfer.rawValue, "WIRE_TRANSFER")
        XCTAssertEqual(PaymentDetail.Method.other.rawValue, "OTHER")
    }
    
    func testAllCase() {
        XCTAssertEqual(PaymentDetail.Method.allCases.count, 8)
        XCTAssertEqual(PaymentDetail.Method.allCases, [.bankTransfer, .cash, .check, .creditCard, .debitCard, .paypal, .wireTransfer, .other])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let bankTransfer = try String(data: encoder.encode(Detail(method: .bankTransfer)), encoding: .utf8)
        let wireTransfer = try String(data: encoder.encode(Detail(method: .wireTransfer)), encoding: .utf8)
        
        XCTAssertEqual(bankTransfer, "{\"method\":\"BANK_TRANSFER\"}")
        XCTAssertEqual(wireTransfer, "{\"method\":\"WIRE_TRANSFER\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let creditCard = """
        {
            "method": "CREDIT_CARD"
        }
        """.data(using: .utf8)!
        let debitCard = """
        {
            "method": "DEBIT_CARD"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Detail.self, from: creditCard).method, .creditCard)
        try XCTAssertEqual(decoder.decode(Detail.self, from: debitCard).method, .debitCard)
    }
    
    static var allTests: [(String, (PaymentDetailMethodTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}







