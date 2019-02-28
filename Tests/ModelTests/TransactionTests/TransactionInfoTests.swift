import XCTest
import Failable
@testable import PayPal

public final class TransactionInfoTests: XCTestCase {
    let now = Date()
    
    func testInit()throws {
        let transaction = try TransactionInfo(
            buyerID: "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A",
            sellerID: "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
            created: self.now,
            status: .pending,
            gross: CurrencyCodeAmount(currency: .usd, value: 89.45),
            invoice: "C80ED435-DBB2-456B-A1EF-2750A32AAF1A",
            custom: nil,
            buyer: Buyer(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather"),
            seller: Seller(email: .init("throg@exmaple.com"), name: "Nag the Nameless", merchantID: nil)
        )
        
        XCTAssertNil(transaction.items)
        XCTAssertNil(transaction.custom)
        
        XCTAssertEqual(transaction.buyerID, "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A")
        XCTAssertEqual(transaction.sellerID, "3DE7148F-360E-4F22-9DE2-8507E24DB60B")
        XCTAssertEqual(transaction.created, self.now)
        XCTAssertEqual(transaction.status, .pending)
        XCTAssertEqual(transaction.invoice, "C80ED435-DBB2-456B-A1EF-2750A32AAF1A")
        
        try XCTAssertEqual(transaction.buyer, Buyer(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather"))
        try XCTAssertEqual(transaction.seller, Seller(email: .init("throg@exmaple.com"), name: "Nag the Nameless", merchantID: nil))
        XCTAssertEqual(transaction.gross, CurrencyCodeAmount(currency: .usd, value: 89.45))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let transaction = try TransactionInfo(
            buyerID: "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A",
            sellerID: "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
            created: self.now,
            status: .pending,
            gross: CurrencyCodeAmount(currency: .usd, value: 89.45),
            invoice: "C80ED435-DBB2-456B-A1EF-2750A32AAF1A",
            custom: nil,
            buyer: Buyer(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather"),
            seller: Seller(email: .init("throg@exmaple.com"), name: "Nag the Nameless", merchantID: nil)
        )
        let generated = try String(data: encoder.encode(transaction), encoding: .utf8)!
        let json =
            "{\"seller\":{\"email\":\"throg@exmaple.com\",\"name\":\"Nag the Nameless\"},\"buyer_transaction_id\":\"DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A\"," +
            "\"seller_transaction_id\":\"3DE7148F-360E-4F22-9DE2-8507E24DB60B\",\"gross_amount\":{\"value\":\"89.45\",\"currency_code\":\"USD\"}," +
            "\"buyer\":{\"email\":\"witheringheights@exmaple.com\",\"name\":\"Leeli Wingfeather\"},\"create_time\":\"\(self.now.iso8601)\"," +
            "\"invoice_number\":\"C80ED435-DBB2-456B-A1EF-2750A32AAF1A\",\"transaction_status\":\"PENDING\"}" 
        
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
            "seller": {
                "email": "throg@exmaple.com",
                "name": "Nag the Nameless"
            },
            "buyer": {
                "email": "witheringheights@exmaple.com",
                "name": "Leeli Wingfeather"
            },
            "invoice_number": "C80ED435-DBB2-456B-A1EF-2750A32AAF1A",
            "gross_amount": {
                "value": "89.45",
                "currency_code": "USD"
            },
            "transaction_status": "PENDING",
            "create_time": "\(self.now.iso8601)\",
            "seller_transaction_id": "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
            "buyer_transaction_id": "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A"
        }
        """.data(using: .utf8)!
        let transaction = try TransactionInfo(
            buyerID: "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A",
            sellerID: "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
            created: self.now,
            status: .pending,
            gross: CurrencyCodeAmount(currency: .usd, value: 89.45),
            invoice: "C80ED435-DBB2-456B-A1EF-2750A32AAF1A",
            custom: nil,
            buyer: Buyer(email: .init("witheringheights@exmaple.com"), name: "Leeli Wingfeather"),
            seller: Seller(email: .init("throg@exmaple.com"), name: "Nag the Nameless", merchantID: nil)
        )
        
        try XCTAssertEqual(transaction, decoder.decode(TransactionInfo.self, from: json))
    }
    
    static var allTests: [(String, (TransactionInfoTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


