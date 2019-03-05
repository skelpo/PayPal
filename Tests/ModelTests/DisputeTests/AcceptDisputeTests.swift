import XCTest
import Failable
@testable import PayPal

public final class AcceptDisputeTests: XCTestCase {
    func testInit()throws {
        let body = try AcceptDisputeBody(
            note: .init("Refund to customer"),
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: CurrencyCodeAmount(currency: .usd, value: 55.50)
        )
        
        XCTAssertNil(body.returnAddress)
        XCTAssertEqual(body.reason, .policy)
        XCTAssertEqual(body.note.value, "Refund to customer")
        XCTAssertEqual(body.invoiceID, "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5")
        XCTAssertEqual(body.refund, CurrencyCodeAmount(currency: .usd, value: 55.50))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(AcceptDisputeBody(
            note: .init(String(repeating: "n", count: 2001)),
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: CurrencyCodeAmount(currency: .usd, value: 55.50)
        ))
        var body = try AcceptDisputeBody(
            note: .init("Refund to customer"),
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: CurrencyCodeAmount(currency: .usd, value: 55.50)
        )
        
        try XCTAssertThrowsError(body.note <~ String(repeating: "n", count: 2001))
        try body.note <~ String(repeating: "n", count: 2000)
        
        XCTAssertEqual(body.note.value, String(repeating: "n", count: 2000))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let body = try AcceptDisputeBody(
            note: .init("Refund to customer"),
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: CurrencyCodeAmount(currency: .usd, value: 55.50)
        )
        let generated = try String(data: encoder.encode(body), encoding: .utf8)!
        let json =
            "{\"accept_claim_reason\":\"COMPANY_POLICY\",\"invoice_id\":\"3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5\"," +
            "\"note\":\"Refund to customer\",\"refund_amount\":{\"value\":\"55.5\",\"currency_code\":\"USD\"}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let body = try AcceptDisputeBody(
            note: .init("Refund to customer"),
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: CurrencyCodeAmount(currency: .usd, value: 55.50)
        )
        let valid = """
        {
            "refund_amount": {
                "value": "55.5",
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
                "value": "55.5",
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
    
    public static var allTests: [(String, (AcceptDisputeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


