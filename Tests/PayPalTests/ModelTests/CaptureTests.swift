import XCTest
@testable import PayPal

final class CaptureTests: XCTestCase {
    func testInit()throws {
        let capture = try Capture(
            amount: DetailedAmount(currency: .usd, total: "10.00", details: nil),
            transaction: Amount(currency: .usd, value: "1.00")
        )
        
        XCTAssertNil(capture.id)
        XCTAssertNil(capture.links)
        XCTAssertNil(capture.status)
        XCTAssertNil(capture.reason)
        try XCTAssertEqual(capture.amount, DetailedAmount(currency: .usd, total: "10.00", details: nil))
        try XCTAssertEqual(capture.transaction, Amount(currency: .usd, value: "1.00"))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let capture = try Capture(
            amount: DetailedAmount(currency: .usd, total: "10.00", details: nil),
            transaction: Amount(currency: .usd, value: "1.00")
        )
        let generated = try String(data: encoder.encode(capture), encoding: .utf8)
        let json = "{\"amount\":{\"currency\":\"USD\",\"total\":\"10.00\"},\"transaction_fee\":{\"value\":\"1.00\",\"currency\":\"USD\"}}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "id": "F5AB876D-3961-4FDC-BDED-6CF8480FA13D",
            "links": [],
            "status": "PENDING",
            "reason_code": "BUYER_COMPLAINT",
            "amount": {
                "total": "10.00",
                "currency": "USD"
            },
            "transaction_fee": {
                "value": "1.00",
                "currency": "USD"
            }
        }
        """.data(using: .utf8)!
        
        let capture = try decoder.decode(Capture.self, from: json)
        XCTAssertEqual(capture.id, "F5AB876D-3961-4FDC-BDED-6CF8480FA13D")
        XCTAssertEqual(capture.links, [])
        XCTAssertEqual(capture.status, .pending)
        XCTAssertEqual(capture.reason, .buyerComplaint)
        try XCTAssertEqual(capture.amount, DetailedAmount(currency: .usd, total: "10.00", details: nil))
        try XCTAssertEqual(capture.transaction, Amount(currency: .usd, value: "1.00"))
    }
    
    static var allTests: [(String, (CaptureTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


