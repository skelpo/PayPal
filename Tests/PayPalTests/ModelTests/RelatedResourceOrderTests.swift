import XCTest
@testable import PayPal

final class RelatedResourceOrderTests: XCTestCase {
    let now = Date()
    
    func testInit()throws {
        let order = try RelatedResource.Order(
            amount: DetailedAmount(currency: .usd, total: "645.12", details: nil),
            fmf: FraudManagementFilter(type: .accept, id: .maxAmount, name: nil, description: nil)
        )
        
        XCTAssertNil(order.id)
        XCTAssertNil(order.mode)
        XCTAssertNil(order.state)
        XCTAssertNil(order.reason)
        XCTAssertNil(order.protection)
        XCTAssertNil(order.protectionType)
        XCTAssertNil(order.parent)
        XCTAssertNil(order.created)
        XCTAssertNil(order.updated)
        XCTAssertNil(order.links)
        
        XCTAssertEqual(order.fmf, FraudManagementFilter(type: .accept, id: .maxAmount, name: nil, description: nil))
        try XCTAssertEqual(order.amount, DetailedAmount(currency: .usd, total: "645.12", details: nil))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let order = try RelatedResource.Order(
            amount: DetailedAmount(currency: .usd, total: "645.12", details: nil),
            fmf: FraudManagementFilter(type: .accept, id: .maxAmount, name: nil, description: nil)
        )
        let generated = try String(data: encoder.encode(order), encoding: .utf8)!
        
        let json = "{\"amount\":{\"currency\":\"USD\",\"total\":\"645.12\"},\"fmf_details\":{\"filter_id\":\"MAXIMUM_TRANSACTION_AMOUNT\",\"filter_type\":\"ACCEPT\"}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let created = Date() + (60 * 60 * 24)
        let updated = Date() + (60 * 60 * 24 * 3)
        
        let decoder = JSONDecoder()
        let json = """
        {
            "id": "C73501DA-4D7F-41FE-9083-F3C3D2BF6C46",
            "amount": {
                "currency": "USD",
                "total": "645.12"
            },
            "payment_mode": "MANUAL_BANK_TRANSFER",
            "state": "pending",
            "reason_code": "VERIFICATION_REQUIRED",
            "protection_eligibility": "ELIGIBLE",
            "protection_eligibility_type": "UNAUTHORIZED_PAYMENT_ELIGIBLE",
            "parent_payment": "2C63C0B7-F06A-4743-8D40-F55CA007A40B",
            "fmf_details": {
                "filter_id": "MAXIMUM_TRANSACTION_AMOUNT",
                "filter_type": "ACCEPT"
            },
            "create_time": "\(created.iso8601)",
            "update_time": "\(updated.iso8601)",
            "links": []
        }
        """.data(using: .utf8)!
        
        let sale = try decoder.decode(RelatedResource.Order.self, from: json)
        
        XCTAssertEqual(sale.id, "C73501DA-4D7F-41FE-9083-F3C3D2BF6C46")
        
        XCTAssertEqual(sale.mode, .manual)
        XCTAssertEqual(sale.state, .pending)
        XCTAssertEqual(sale.reason, .verification)
        XCTAssertEqual(sale.protection, .eligible)
        XCTAssertEqual(sale.protectionType, .unauthorizedPayment)
        XCTAssertEqual(sale.fmf, FMF(type: .accept, id: .maxAmount, name: nil, description: nil))
        XCTAssertEqual(sale.parent, "2C63C0B7-F06A-4743-8D40-F55CA007A40B")
        XCTAssertEqual(sale.created, created.iso8601)
        XCTAssertEqual(sale.updated, updated.iso8601)
        XCTAssertEqual(sale.links, [])
        
        try XCTAssertEqual(sale.amount, DetailedAmount(currency: .usd, total: "645.12", details: nil))
    }
    
    static var allTests: [(String, (RelatedResourceOrderTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




