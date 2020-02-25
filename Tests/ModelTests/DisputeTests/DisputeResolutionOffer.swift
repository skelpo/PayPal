import XCTest
import Failable
@testable import PayPal

public final class DisputeResolutionOfferTests: XCTestCase {
    func testInit()throws {
        let offer = try CustomerDispute.ResolutionOffer(
            note: .init("Offer refund with replacement item."),
            amount: CurrencyCodeAmount(currency: .usd, value: 23),
            type: .replacement,
            returnAddress: nil,
            invoiceID: nil
        )
        
        XCTAssertNil(offer.invoiceID)
        XCTAssertNil(offer.returnAddress)
        XCTAssertEqual(offer.type, .replacement)
        XCTAssertEqual(offer.note.value, "Offer refund with replacement item.")
        XCTAssertEqual(offer.amount, CurrencyCodeAmount(currency: .usd, value: 23))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(CustomerDispute.ResolutionOffer(
            note: .init(String(repeating: "n", count: 2001)),
            amount: CurrencyCodeAmount(currency: .usd, value: 23),
            type: .replacement,
            returnAddress: nil,
            invoiceID: nil
        ))
        try XCTAssertThrowsError(CustomerDispute.ResolutionOffer(
            note: .init(""),
            amount: CurrencyCodeAmount(currency: .usd, value: 23),
            type: .replacement,
            returnAddress: nil,
            invoiceID: nil
        ))
        
        var offer = try CustomerDispute.ResolutionOffer(
            note: .init("Offer refund with replacement item."),
            amount: CurrencyCodeAmount(currency: .usd, value: 23),
            type: .replacement,
            returnAddress: nil,
            invoiceID: nil
        )
        
        try XCTAssertThrowsError(offer.note <~ "")
        try offer.note <~ "Notable"
        
        XCTAssertEqual(offer.note.value, "Notable")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let offer = try CustomerDispute.ResolutionOffer(
            note: .init("Notable note."),
            amount: CurrencyCodeAmount(currency: .usd, value: 23),
            type: .replacement,
            returnAddress: nil,
            invoiceID: nil
        )
        let generated = try String(data: encoder.encode(offer), encoding: .utf8)!
        let json =
            "{\"offer_type\":\"REFUND_WITH_REPLACEMENT\",\"offer_amount\":{\"value\":\"23\",\"currency_code\":\"USD\"},\"note\":\"Notable note.\"}"
        
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
            "offer_type": "REFUND_WITH_REPLACEMENT",
            "offer_amount": {
                "currency_code": "USD",
                "value": "23"
            },
            "note": "Notable note."
        }
        """.data(using: .utf8)!
        let noteShort = """
        {
            "offer_type": "REFUND_WITH_REPLACEMENT",
            "offer_amount": {
                "currency_code": "USD",
                "value": "23"
            },
            "note": ""
        }
        """.data(using: .utf8)!
        let noteLong = """
        {
            "offer_type": "REFUND_WITH_REPLACEMENT",
            "offer_amount": {
                "currency_code": "USD",
                "value": "23"
            },
            "note": "\(String(repeating: "n", count: 2001))"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(CustomerDispute.ResolutionOffer.self, from: noteLong))
        try XCTAssertThrowsError(decoder.decode(CustomerDispute.ResolutionOffer.self, from: noteShort))
        try XCTAssertEqual(decoder.decode(CustomerDispute.ResolutionOffer.self, from: json), CustomerDispute.ResolutionOffer(
            note: .init("Notable note."),
            amount: CurrencyCodeAmount(currency: .usd, value: 23),
            type: .replacement,
            returnAddress: nil,
            invoiceID: nil
        ))
    }
    
    public static var allTests: [(String, (DisputeResolutionOfferTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



