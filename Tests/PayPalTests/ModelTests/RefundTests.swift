import XCTest
@testable import PayPal

final class RefundTests: XCTestCase {
    func testInit()throws {
        let refund = try Refund(amount: DetailedAmount(currency: .usd, total: "10.00", details: nil))
        
        try XCTAssertEqual(refund.amount, DetailedAmount(currency: .usd, total: "10.00", details: nil))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let refund = try Refund(amount: DetailedAmount(currency: .usd, total: "10.00", details: nil))
        let generated = try String(data: encoder.encode(refund), encoding: .utf8)!
        let json = "{\"amount\":{\"currency\":\"USD\",\"total\":\"10.00\"}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "id": "259CEDEE-4A03-45A0-B088-B6A318544619",
            "amount": {
                "total": "10.00",
                "currency": "USD"
            },
            "capture_id": "FE3ABA6E-8DB4-4379-A9A7-81A0725F3DE3",
            "sale_id": "3B9C13B1-B7C0-494F-B6F2-DE8365052806",
            "status": "PENDING",
            "links": []
        }
        """.data(using: .utf8)!
        
        let refund = try decoder.decode(Refund.self, from: json)
        
        XCTAssertEqual(refund.id, "259CEDEE-4A03-45A0-B088-B6A318544619")
        XCTAssertEqual(refund.capture, "FE3ABA6E-8DB4-4379-A9A7-81A0725F3DE3")
        XCTAssertEqual(refund.sale, "3B9C13B1-B7C0-494F-B6F2-DE8365052806")
        XCTAssertEqual(refund.status, .pending)
        XCTAssertEqual(refund.links, [])
        try XCTAssertEqual(refund.amount, DetailedAmount(currency: .usd, total: "10.00", details: nil))
    }
    
    static var allTests: [(String, (RefundTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




