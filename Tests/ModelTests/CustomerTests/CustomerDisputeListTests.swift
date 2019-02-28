import XCTest
@testable import PayPal

public final class CustomerDisputeListTests: XCTestCase {
    let date = Date()
    let due = Date(timeIntervalSinceNow: 60 * 60 * 24)
    
    func testInit()throws {
        let list = try CustomerDisputeList(items: [
            CustomerDispute(
                transactions: [
                    TransactionInfo(
                        buyerID: "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A",
                        sellerID: "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
                        created: self.date,
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
        ])
        
        XCTAssertNil(list.links)
        XCTAssertEqual(list.items?.count, 1)
        try XCTAssertEqual(list.items?.first, CustomerDispute(
            transactions: [
                TransactionInfo(
                    buyerID: "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A",
                    sellerID: "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
                    created: self.date,
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
        ))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let list = CustomerDisputeList(items: [
            CustomerDispute(
                transactions: [],
                reason: .unauthorized,
                amount: CurrencyCodeAmount(currency: .usd, value: 89.45),
                messages: nil,
                responseDue: self.due
            )
        ])
        let generated = try String(data: encoder.encode(list), encoding: .utf8)
        let json =
            "{\"items\":[{\"dispute_amount\":{\"value\":\"89.45\",\"currency_code\":\"USD\"},\"reason\":\"UNAUTHORISED\"," +
            "\"seller_response_due_date\":\"\(self.due.iso8601)\",\"disputed_transactions\":[]}]}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "items": [
                {
                    "seller_response_due_date": "\(self.due.iso8601)",
                    "dispute_amount": {
                        "value": "89.45",
                        "currency_code": "USD"
                    },
                    "reason": "UNAUTHORISED",
                    "disputed_transactions": []
                }
            ]
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(
            decoder.decode(CustomerDisputeList.self, from: json),
            CustomerDisputeList(items: [
                CustomerDispute(
                    transactions: [],
                    reason: .unauthorized,
                    amount: CurrencyCodeAmount(currency: .usd, value: 89.45),
                    messages: nil,
                    responseDue: self.due
                )
            ])
        )
    }
    
    static var allTests: [(String, (CustomerDisputeListTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

