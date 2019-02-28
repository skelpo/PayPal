import XCTest
@testable import PayPal

public final class CustomerDisputeTests: XCTestCase {
    let created = Date()
    let due = Date(timeIntervalSinceNow: 60 * 60 * 24)
    
    func testInit()throws {
        let dispute = try CustomerDispute(
            transactions: [
                TransactionInfo(
                    buyerID: "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A",
                    sellerID: "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
                    created: created,
                    status: .pending,
                    gross: CurrencyCodeAmount(currency: .usd, value: 89.45),
                    invoice: "C80ED435-DBB2-456B-A1EF-2750A32AAF1A",
                    custom: nil,
                    buyer: Buyer(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather"),
                    seller: Seller(email: .init("throg@exmaple.com"), name: "Nag the Nameless", merchantID: nil)
                )
            ],
            reason: .unauthorized,
            amount: CurrencyCodeAmount(currency: .usd, value: 89.45),
            messages: nil,
            responseDue: self.due
        )
        
        XCTAssertNil(dispute.id)
        XCTAssertNil(dispute.created)
        XCTAssertNil(dispute.updated)
        XCTAssertNil(dispute.status)
        XCTAssertNil(dispute.outcome)
        XCTAssertNil(dispute.lifecycleStage)
        XCTAssertNil(dispute.channel)
        XCTAssertNil(dispute.offer)
        XCTAssertNil(dispute.links)
        XCTAssertNil(dispute.messages)
        
        XCTAssertEqual(dispute.reason, .unauthorized)
        XCTAssertEqual(dispute.responseDue, self.due)
        XCTAssertEqual(dispute.transactions?.count, 1)
        try XCTAssertEqual(dispute.transactions?.first, TransactionInfo(
            buyerID: "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A",
            sellerID: "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
            created: created,
            status: .pending,
            gross: CurrencyCodeAmount(currency: .usd, value: 89.45),
            invoice: "C80ED435-DBB2-456B-A1EF-2750A32AAF1A",
            custom: nil,
            buyer: Buyer(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather"),
            seller: Seller(email: .init("throg@exmaple.com"), name: "Nag the Nameless", merchantID: nil)
        ))
        XCTAssertEqual(dispute.amount, CurrencyCodeAmount(currency: .usd, value: 89.45))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let dispute = CustomerDispute(
            transactions: [],
            reason: .unauthorized,
            amount: CurrencyCodeAmount(currency: .usd, value: 89.45),
            messages: nil,
            responseDue: self.due
        )
        let generated = try String(data: encoder.encode(dispute), encoding: .utf8)!
        let json =
            "{\"dispute_amount\":{\"value\":\"89.45\",\"currency_code\":\"USD\"},\"reason\":\"UNAUTHORISED\",\"seller_response_due_date\":\"\(self.due.iso8601)\"," +
            "\"disputed_transactions\":[]}"
        
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
        let min = """
        {
            "seller_response_due_date": "\(self.due.iso8601)",
            "dispute_amount": {
                "value": "89.45",
                "currency_code": "USD"
            },
            "reason": "UNAUTHORISED",
            "disputed_transactions": []
        }
        """.data(using: .utf8)!
        let more = """
        {
            "dispute_id": "B321E1FA-5F62-4599-99C1-C6E933AEBBE4",
            "create_time": "\(self.due.iso8601)",
            "update_time": "\(self.due.iso8601)",
            "status": "WAITING_FOR_SELLER_RESPONSE",
            "dispute_life_cycle_stage": "INQUIRY",
            "dispute_channel": "INTERNAL",
            "seller_response_due_date": "\(self.due.iso8601)",
            "dispute_amount": {
                "value": "89.45",
                "currency_code": "USD"
            },
            "reason": "UNAUTHORISED",
            "disputed_transactions": []
        }
        """.data(using: .utf8)!
        let dateFail = """
        {
            "seller_response_due_date": "1/2/13 1:24:54pm",
            "dispute_amount": {
                "value": "89.45",
                "currency_code": "USD"
            },
            "reason": "UNAUTHORISED",
            "disputed_transactions": []
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(CustomerDispute.self, from: dateFail))
        try XCTAssertEqual(decoder.decode(CustomerDispute.self, from: min), CustomerDispute(
            transactions: [],
            reason: .unauthorized,
            amount: CurrencyCodeAmount(currency: .usd, value: 89.45),
            messages: nil,
            responseDue: self.due
        ))
        
        let dispute = try decoder.decode(CustomerDispute.self, from: more)

        XCTAssertEqual(dispute.id, "B321E1FA-5F62-4599-99C1-C6E933AEBBE4")
        XCTAssertEqual(dispute.created, self.due)
        XCTAssertEqual(dispute.updated, self.due)
        XCTAssertEqual(dispute.status, .waitingSeller)
        XCTAssertEqual(dispute.lifecycleStage, .inquiry)
        XCTAssertEqual(dispute.channel, .internal)
    }
    
    public static var allTests: [(String, (CustomerDisputeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


