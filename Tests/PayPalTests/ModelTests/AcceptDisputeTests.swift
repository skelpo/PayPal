import XCTest
@testable import PayPal

final class AcceptDisputeTests: XCTestCase {
    func testInit()throws {
        let body = try AcceptDisputeBody(
            note: "Refund to customer",
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: Money(currency: .usd, value: "55.50")
        )
        
        XCTAssertNil(body.returnAddress)
        XCTAssertEqual(body.note, "Refund to customer")
        XCTAssertEqual(body.reason, .policy)
        XCTAssertEqual(body.invoiceID, "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5")
        try XCTAssertEqual(body.refund, Money(currency: .usd, value: "55.50"))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(AcceptDisputeBody(
            note: String(repeating: "n", count: 2001),
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: Money(currency: .usd, value: "55.50")
        ))
        var body = try AcceptDisputeBody(
            note: "Refund to customer",
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: Money(currency: .usd, value: "55.50")
        )
        
        try XCTAssertThrowsError(body.set(\AcceptDisputeBody.note <~ String(repeating: "n", count: 2001)))
        try body.set(\AcceptDisputeBody.note <~ String(repeating: "n", count: 2000))
        
        XCTAssertEqual(body.note, String(repeating: "n", count: 2000))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let body = try AcceptDisputeBody(
            note: "Refund to customer",
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: Money(currency: .usd, value: "55.50")
        )
        let generated = try String(data: encoder.encode(body), encoding: .utf8)!
        let json =
            "{\"refund_amount\":{\"value\":\"55.50\",\"currency_code\":\"USD\"},\"invoice_id\":\"3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5\"," +
            "\"accept_claim_reason\":\"COMPANY_POLICY\",\"note\":\"Refund to customer\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let body = try AcceptDisputeBody(
            note: "Refund to customer",
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: Money(currency: .usd, value: "55.50")
        )
        let valid = """
        {
            "refund_amount": {
                "value": "55.50",
                "currency_code": "USD"
            },
            "invoice_id": "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            "accept_claim_reason": "COMPANY_POLICY",
            "note": "Refund to customer"
        }
        """.data(using: .utf8)!
        let noteFail = """
        {
            "refund_amount": {
                "value": "55.50",
                "currency_code": "USD"
            },
            "invoice_id": "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            "accept_claim_reason": "COMPANY_POLICY",
            "note": "\(String(repeating: "n", count: 2001))"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(AcceptDisputeBody.self, from: noteFail))
        try XCTAssertEqual(body, decoder.decode(AcceptDisputeBody.self, from: valid))
    }
    
    static var allTests: [(String, (AcceptDisputeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


