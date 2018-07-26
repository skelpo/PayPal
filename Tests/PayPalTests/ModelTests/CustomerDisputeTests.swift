import XCTest
@testable import PayPal

final class CustomerDisputeTests: XCTestCase {
    let due = Date(timeIntervalSinceNow: 60 * 60 * 24).iso8601
    
    func testInit()throws {
        let dispute = try CustomerDispute(
            transactions: [
                TransactionInfo(
                    buyerID: "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A",
                    sellerID: "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
                    created: Date().iso8601,
                    status: .pending,
                    gross: Money(currency: .usd, value: "89.45"),
                    invoice: "C80ED435-DBB2-456B-A1EF-2750A32AAF1A",
                    custom: nil,
                    buyer: Buyer(email: "witheringheights@exmaple.com", name: "Leeli Wingfeather"),
                    seller: Seller(email: "throg@exmaple.com", name: "Nag the Nameless", merchantID: nil)
                )
            ],
            reason: .unauthorized,
            amount: Money(currency: .usd, value: "89.45"),
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
            created: Date().iso8601,
            status: .pending,
            gross: Money(currency: .usd, value: "89.45"),
            invoice: "C80ED435-DBB2-456B-A1EF-2750A32AAF1A",
            custom: nil,
            buyer: Buyer(email: "witheringheights@exmaple.com", name: "Leeli Wingfeather"),
            seller: Seller(email: "throg@exmaple.com", name: "Nag the Nameless", merchantID: nil)
        ))
        try XCTAssertEqual(dispute.amount, Money(currency: .usd, value: "89.45"))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(CustomerDispute(
            transactions: [],
            reason: .unauthorized,
            amount: Money(currency: .usd, value: "89.45"),
            messages: nil,
            responseDue: "0000-09-10T23:56:60.999999999999999999999999999999999999999-22:88"
        ))
        try XCTAssertThrowsError(CustomerDispute(
            transactions: [],
            reason: .unauthorized,
            amount: Money(currency: .usd, value: "89.45"),
            messages: nil,
            responseDue: "1/2/13 1:24:54pm"
        ))
        
        var dispute = try CustomerDispute(
            transactions: [],
            reason: .unauthorized,
            amount: Money(currency: .usd, value: "89.45"),
            messages: nil,
            responseDue: self.due
        )
        
        let later = Date(timeIntervalSinceNow: 60 * 60 * 24).iso8601
        try XCTAssertThrowsError(dispute.set(\.responseDue <~ "1/2/13 1:24:54pm"))
        try dispute.set(\CustomerDispute.responseDue <~ later)
        
        XCTAssertEqual(dispute.responseDue, later)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let dispute = try CustomerDispute(
            transactions: [],
            reason: .unauthorized,
            amount: Money(currency: .usd, value: "89.45"),
            messages: nil,
            responseDue: self.due
        )
        let generated = try String(data: encoder.encode(dispute), encoding: .utf8)!
        let json =
            "{\"seller_response_due_date\":\"\(self.due)\",\"dispute_amount\":{\"value\":\"89.45\",\"currency_code\":\"USD\"},\"reason\":\"AUTHORISED\"," +
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
            "seller_response_due_date": "\(self.due)",
            "dispute_amount": {
                "value": "89.45",
                "currency_code": "USD"
            },
            "reason": "AUTHORISED",
            "disputed_transactions": []
        }
        """.data(using: .utf8)!
        let more = """
        {
            "dispute_id": "B321E1FA-5F62-4599-99C1-C6E933AEBBE4",
            "create_time": "\(self.due)",
            "update_time": "\(self.due)",
            "status": "WAITING_FOR_SELLER_RESPONSE",
            "dispute_life_cycle_stage", "INQUIRY",
            "dispute_channel": "INTERNAL",
            "seller_response_due_date": "\(self.due)",
            "dispute_amount": {
                "value": "89.45",
                "currency_code": "USD"
            },
            "reason": "AUTHORISED",
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
            "reason": "AUTHORISED",
            "disputed_transactions": []
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(CustomerDispute.self, from: dateFail))
        try XCTAssertEqual(decoder.decode(CustomerDispute.self, from: min), CustomerDispute(
            transactions: [],
            reason: .unauthorized,
            amount: Money(currency: .usd, value: "89.45"),
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
    
    static var allTests: [(String, (CustomerDisputeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

