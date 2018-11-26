import XCTest
@testable import PayPal

final class RelatedResourceSaleTests: XCTestCase {
    let now = Date()
    
    func testInit()throws {
        let sale = RelatedResource.Sale(
            id: "9FF17892-49F8-47C9-8117-7662F889DAEA",
            amount: DetailedAmount(currency: .usd, total: 42.31, details: nil),
            state: .pending,
            transaction: CurrencyAmount(currency: .usd, value: 0.31),
            receivable: CurrencyAmount(currency: .usd, value: 42.00),
            exchangeRate: "0.0",
            fmf: .init(type: .deny, id: .addressMismatch, name: "Name", description: "Desc."),
            processor: .init(code: "6399", avs: "e", cvv: "h", advice: .newAccount, eci: "152823", vpas: "stat"),
            parent: "E7FBF930-B0F3-4514-B1DD-810BDCD6541F",
            created: self.now.iso8601
        )
        
        XCTAssertEqual(sale.id, "9FF17892-49F8-47C9-8117-7662F889DAEA")
        XCTAssertEqual(sale.state, .pending)
        XCTAssertEqual(sale.exchangeRate, "0.0")
        XCTAssertEqual(sale.fmf, .init(type: .deny, id: .addressMismatch, name: "Name", description: "Desc."))
        XCTAssertEqual(sale.processor, .init(code: "6399", avs: "e", cvv: "h", advice: .newAccount, eci: "152823", vpas: "stat"))
        XCTAssertEqual(sale.parent, "E7FBF930-B0F3-4514-B1DD-810BDCD6541F")
        XCTAssertEqual(sale.created, self.now.iso8601)
        XCTAssertEqual(sale.transaction, CurrencyAmount(currency: .usd, value: 0.31))
        XCTAssertEqual(sale.receivable, CurrencyAmount(currency: .usd, value: 42.00))
        XCTAssertEqual(sale.amount, DetailedAmount(currency: .usd, total: 42.31, details: nil))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let sale = RelatedResource.Sale(
            id: "9FF17892-49F8-47C9-8117-7662F889DAEA",
            amount: DetailedAmount(currency: .usd, total: 42.31, details: nil),
            state: .pending,
            transaction: CurrencyAmount(currency: .usd, value: 0.31),
            receivable: CurrencyAmount(currency: .usd, value: 42.00),
            exchangeRate: "0.0",
            fmf: .init(type: .deny, id: .addressMismatch, name: "Name", description: "Desc."),
            processor: .init(code: "6399", avs: "e", cvv: "h", advice: .newAccount, eci: "152823", vpas: "stat"),
            parent: "E7FBF930-B0F3-4514-B1DD-810BDCD6541F",
            created: self.now.iso8601
        )
        let generated = try String(data: encoder.encode(sale), encoding: .utf8)!
        
        let json = "{\"amount\":{\"currency\":\"USD\",\"total\":\"42.31\"},\"id\":\"9FF17892-49F8-47C9-8117-7662F889DAEA\",\"exchange_rate\":\"0.0\",\"transaction_fee\":{\"value\":\"0.31\",\"currency\":\"USD\"},\"receivable_amount\":{\"value\":\"42.00\",\"currency\":\"USD\"},\"fmf_details\":{\"filter_id\":\"BILLING_OR_SHIPPING_ADDRESS_MISMATCH\",\"name\":\"Name\",\"description\":\"Desc.\",\"filter_type\":\"DENY\"},\"create_time\":\"\(self.now.iso8601)\",\"parent_payment\":\"E7FBF930-B0F3-4514-B1DD-810BDCD6541F\",\"state\":\"pending\",\"processor_response\":{\"avs_code\":\"e\",\"response_code\":\"6399\",\"advice_code\":\"01_NEW_ACCOUNT_INFORMATION\",\"cvv_code\":\"h\",\"eci_submitted\":\"152823\",\"vpas\":\"stat\"}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let clearing = Date() + (60 * 60 * 24 * 7)
        let updated = Date() + (60 * 60 * 24 * 3)
        
        let decoder = JSONDecoder()
        let json = """
        {
            "id": "9FF17892-49F8-47C9-8117-7662F889DAEA",
            "purchase_unit_reference_id": "2210DFF6-4FBB-4A2A-9B2A-EA63AD139E47",
            "amount": {
                "currency": "USD",
                "total": "42.31"
            },
            "payment_mode": "INSTANT_TRANSFER",
            "state": "pending",
            "reason_code": "CHARGEBACK",
            "protection_eligibility": "ELIGIBLE",
            "protection_eligibility_type": "UNAUTHORIZED_PAYMENT_ELIGIBLE",
            "clearing_time": "\(clearing.iso8601)",
            "payment_hold_status": "HELD",
            "payment_hold_reasons": [],
            "transaction_fee": {
                "currency": "USD",
                "value": "0.31"
            },
            "receivable_amount": {
                "currency": "USD",
                "value": "42.00"
            },
            "exchange_rate": "0.0",
            "fmf_details": {
                "name": "Name",
                "description": "Desc.",
                "filter_type": "DENY",
                "filter_id": "BILLING_OR_SHIPPING_ADDRESS_MISMATCH"
            },
            "receipt_id": "2784-8646-6863-4296",
            "parent_payment": "92752C9C-5FA2-425D-A03E-5716C5ED67E2",
            "processor_response": {
                "response_code": "6399",
                "avs_code": "e",
                "cvv_code": "h",
                "advice_code": "01_NEW_ACCOUNT_INFORMATION",
                "eci_submitted": "152823",
                "vpas": "stat"
            },
            "billing_agreement_id": "A9A2ACB1-5C01-4B92-807D-F04C08F570C5",
            "create_time": "\(self.now.iso8601)",
            "update_time": "\(updated.iso8601)",
            "links": []
        }
        """.data(using: .utf8)!
        
        let sale = try decoder.decode(RelatedResource.Sale.self, from: json)
        
        XCTAssertEqual(sale.id, "9FF17892-49F8-47C9-8117-7662F889DAEA")
        XCTAssertEqual(sale.purchaseID, "2210DFF6-4FBB-4A2A-9B2A-EA63AD139E47")
        XCTAssertEqual(sale.mode, .instantTransfer)
        XCTAssertEqual(sale.state, .pending)
        XCTAssertEqual(sale.reason, .chargeback)
        XCTAssertEqual(sale.protection, .eligible)
        XCTAssertEqual(sale.protectionType, .unauthorizedPayment)
        XCTAssertEqual(sale.clearing, clearing.iso8601)
        XCTAssertEqual(sale.holdStatus, "HELD")
        XCTAssertEqual(sale.holdReasons, [])
        XCTAssertEqual(sale.exchangeRate, "0.0")
        XCTAssertEqual(sale.fmf, FMF(type: .deny, id: .addressMismatch, name: "Name", description: "Desc."))
        XCTAssertEqual(sale.receipt, "2784-8646-6863-4296")
        XCTAssertEqual(sale.parent, "92752C9C-5FA2-425D-A03E-5716C5ED67E2")
        XCTAssertEqual(sale.billingAgreement, "A9A2ACB1-5C01-4B92-807D-F04C08F570C5")
        XCTAssertEqual(sale.created, self.now.iso8601)
        XCTAssertEqual(sale.updated, updated.iso8601)
        XCTAssertEqual(sale.links, [])
        XCTAssertEqual(
            sale.processor,
            RelatedResource.ProcessorResponse(code: "6399", avs: "e", cvv: "h", advice: .newAccount, eci: "152823", vpas: "stat")
        )
        
        XCTAssertEqual(sale.receivable, CurrencyAmount(currency: .usd, value: 42.00))
        XCTAssertEqual(sale.transaction, CurrencyAmount(currency: .usd, value: 0.31))
        XCTAssertEqual(sale.amount, DetailedAmount(currency: .usd, total: 42.31, details: nil))
    }
    
    static var allTests: [(String, (RelatedResourceSaleTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



