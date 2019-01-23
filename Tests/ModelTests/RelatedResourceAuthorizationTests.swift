import XCTest
@testable import PayPal

final class RelatedResourceAuthorizationTests: XCTestCase {
    let now = Date()
    
    func testInit()throws {
        let auth = RelatedResource.Authorization(
            amount: .init(currency: .usd, total: 5896.00, details: nil),
            fmf: .init(type: .deny, id: .addressMismatch, name: "Name", description: "Desc."),
            processor: .init(code: "6399", avs: "e", cvv: "h", advice: .newAccount, eci: "152823", vpas: "stat")
        )
        
        XCTAssertNil(auth.id)
        XCTAssertNil(auth.mode)
        XCTAssertNil(auth.state)
        XCTAssertNil(auth.reason)
        XCTAssertNil(auth.protection)
        XCTAssertNil(auth.protectionType)
        XCTAssertNil(auth.payment)
        XCTAssertNil(auth.expiration)
        XCTAssertNil(auth.created)
        XCTAssertNil(auth.updated)
        XCTAssertNil(auth.receipt)
        XCTAssertNil(auth.links)
        
        XCTAssertEqual(auth.fmf, .init(type: .deny, id: .addressMismatch, name: "Name", description: "Desc."))
        XCTAssertEqual(auth.processor, .init(code: "6399", avs: "e", cvv: "h", advice: .newAccount, eci: "152823", vpas: "stat"))
        XCTAssertEqual(auth.amount, .init(currency: .usd, total: 5896.00, details: nil))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let auth = RelatedResource.Authorization(
            amount: .init(currency: .usd, total: 5896.00, details: nil),
            fmf: .init(type: .deny, id: .addressMismatch, name: "Name", description: "Desc."),
            processor: .init(code: "6399", avs: "e", cvv: "h", advice: .newAccount, eci: "152823", vpas: "stat")
        )
        let generated = try String(data: encoder.encode(auth), encoding: .utf8)!
        
        let json = "{\"amount\":{\"total\":\"5896\",\"currency\":\"USD\"},\"fmf_details\":{\"filter_id\":\"BILLING_OR_SHIPPING_ADDRESS_MISMATCH\",\"name\":\"Name\",\"description\":\"Desc.\",\"filter_type\":\"DENY\"},\"processor_response\":{\"avs_code\":\"e\",\"response_code\":\"6399\",\"advice_code\":\"01_NEW_ACCOUNT_INFORMATION\",\"cvv_code\":\"h\",\"eci_submitted\":\"152823\",\"vpas\":\"stat\"}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let expire = Date() + (60 * 60 * 24 * 7)
        let updated = Date() + (60 * 60 * 24 * 3)
        
        let decoder = JSONDecoder()
        let json = """
        {
            "id": "9FF17892-49F8-47C9-8117-7662F889DAEA",
            "amount": {
                "currency": "USD",
                "total": "42.31"
            },
            "payment_mode": "INSTANT_TRANSFER",
            "state": "pending",
            "reason_code": "AUTHORIZATION",
            "protection_eligibility": "ELIGIBLE",
            "protection_eligibility_type": "UNAUTHORIZED_PAYMENT_ELIGIBLE",
            "fmf_details": {
                "name": "Name",
                "description": "Desc.",
                "filter_type": "DENY",
                "filter_id": "BILLING_OR_SHIPPING_ADDRESS_MISMATCH"
            },
            "parent_payment": "92752C9C-5FA2-425D-A03E-5716C5ED67E2",
            "processor_response": {
                "response_code": "6399",
                "avs_code": "e",
                "cvv_code": "h",
                "advice_code": "01_NEW_ACCOUNT_INFORMATION",
                "eci_submitted": "152823",
                "vpas": "stat"
            },
            "valid_until": "\(expire.iso8601)",
            "create_time": "\(self.now.iso8601)",
            "update_time": "\(updated.iso8601)",
            "receipt_id": "2784-8646-6863-4296",
            "links": []
        }
        """.data(using: .utf8)!
        
        let auth = try decoder.decode(RelatedResource.Authorization.self, from: json)
        
        XCTAssertEqual(auth.id, "9FF17892-49F8-47C9-8117-7662F889DAEA")
        XCTAssertEqual(auth.mode, .instant)
        XCTAssertEqual(auth.state, .pending)
        XCTAssertEqual(auth.reason, .authorization)
        XCTAssertEqual(auth.protection, .eligible)
        XCTAssertEqual(auth.protectionType, .unauthorizedPayment)
        XCTAssertEqual(auth.fmf, FMF(type: .deny, id: .addressMismatch, name: "Name", description: "Desc."))
        XCTAssertEqual(auth.payment, "92752C9C-5FA2-425D-A03E-5716C5ED67E2")
        XCTAssertEqual(auth.expiration, expire)
        XCTAssertEqual(auth.created, self.now)
        XCTAssertEqual(auth.updated, updated)
        XCTAssertEqual(auth.receipt, "2784-8646-6863-4296")
        XCTAssertEqual(auth.links, [])
        XCTAssertEqual(
            auth.processor,
            RelatedResource.ProcessorResponse(code: "6399", avs: "e", cvv: "h", advice: .newAccount, eci: "152823", vpas: "stat")
        )
        
        XCTAssertEqual(auth.amount, DetailedAmount(currency: .usd, total: 42.31, details: nil))
    }
    
    static var allTests: [(String, (RelatedResourceAuthorizationTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




