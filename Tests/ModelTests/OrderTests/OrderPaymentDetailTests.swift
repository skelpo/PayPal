import XCTest
@testable import PayPal

public final class OrderPaymentDetailTests: XCTestCase {
    func testDecoding()throws {
        let json = """
        {
            "payment_id": "2BF302DF-F688-49E6-A600-ECB9F6FECE91",
            "disbursement_mode": "INSTANT"
        }
        """.data(using: .utf8)!
        
        let details = try JSONDecoder().decode(Order.PaymentDetails.self, from: json)
        XCTAssertEqual(details.payment, "2BF302DF-F688-49E6-A600-ECB9F6FECE91")
        XCTAssertEqual(details.disbursement, .instant)
    }
    
    public static var allTests: [(String, (OrderPaymentDetailTests) -> ()throws -> ())] = [
        ("testDecoding", testDecoding)
    ]
}
