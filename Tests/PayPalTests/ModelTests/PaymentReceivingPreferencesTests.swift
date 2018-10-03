import XCTest
@testable import PayPal

final class PaymentReceivingPreferencesTests: XCTestCase {
    func testInit()throws {
        let preference = try PaymentReceivingPreferences(
            blockUnconfirmedUSAddress: true,
            blockNonUS: false,
            blockEcheck: false,
            blockCrossCurrency: true,
            blockSendMoney: false,
            alternatePayment: "https://example.com/alternate",
            displayInstructionsInput: true,
            ccDescriptor: "NOT-SURE",
            ccDescriptorExtended: "NOTE-SURE-AGAIN"
        )
        
        XCTAssertEqual(preference.blockUnconfirmedUSAddress, true)
        XCTAssertEqual(preference.blockNonUS, false)
        XCTAssertEqual(preference.blockEcheck, false)
        XCTAssertEqual(preference.blockCrossCurrency, true)
        XCTAssertEqual(preference.blockSendMoney, false)
        XCTAssertEqual(preference.alternatePayment, "https://example.com/alternate")
        XCTAssertEqual(preference.displayInstructionsInput, true)
        XCTAssertEqual(preference.ccDescriptor, "NOT-SURE")
        XCTAssertEqual(preference.ccDescriptorExtended, "NOTE-SURE-AGAIN")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(PaymentReceivingPreferences(ccDescriptor: "C"))
        try XCTAssertThrowsError(PaymentReceivingPreferences(ccDescriptor: "CCCCCCCCCCCC"))
        try XCTAssertThrowsError(PaymentReceivingPreferences(ccDescriptorExtended: "C"))
        try XCTAssertThrowsError(PaymentReceivingPreferences(ccDescriptorExtended: "CCCCCCCCCCCCCCCCCCCC"))
        var preference = try PaymentReceivingPreferences(ccDescriptor: "NOT-SURE", ccDescriptorExtended: "NOTE-SURE-AGAIN")
        
        try XCTAssertThrowsError(preference.set(\.ccDescriptor <~ "C"))
        try XCTAssertThrowsError(preference.set(\.ccDescriptor <~ "CCCCCCCCCCCC"))
        try XCTAssertThrowsError(preference.set(\.ccDescriptorExtended <~ "C"))
        try XCTAssertThrowsError(preference.set(\.ccDescriptorExtended <~ "CCCCCCCCCCCCCCCCCCCC"))
        try preference.set(\.ccDescriptor <~ "NOW-SURE")
        try preference.set(\.ccDescriptorExtended <~ "NOW-SURE-AGAIN")
        
        XCTAssertEqual(preference.ccDescriptor, "NOW-SURE")
        XCTAssertEqual(preference.ccDescriptorExtended, "NOW-SURE-AGAIN")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let preference = try PaymentReceivingPreferences(
            blockUnconfirmedUSAddress: true,
            blockNonUS: false,
            blockEcheck: false,
            blockCrossCurrency: true,
            blockSendMoney: false,
            alternatePayment: "https://example.com/alternate",
            displayInstructionsInput: true,
            ccDescriptor: "NOT-SURE",
            ccDescriptorExtended: "NOTE-SURE-AGAIN"
        )
        let generated = try String(data: encoder.encode(preference), encoding: .utf8)!
        let json =
            "{\"display_instructions_text_input\":true,\"cc_soft_descriptor_extended\":\"NOTE-SURE-AGAIN\",\"block_unconfirmed_us_address_payments\":true," +
            "\"block_cross_currency_payments\":true,\"cc_soft_descriptor\":\"NOT-SURE\",\"block_echeck_payments\":false," +
            "\"block_send_money_payments\":false,\"alternate_payment_url\":\"https:\\/\\/example.com\\/alternate\",\"block_non_us_payments\":false}"
        
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
            "cc_soft_descriptor_extended": "NOTE-SURE-AGAIN",
            "cc_soft_descriptor": "NOT-SURE",
            "display_instructions_text_input": true,
            "alternate_payment_url": "https://example.com/alternate",
            "block_send_money_payments": false,
            "block_cross_currency_payments": true,
            "block_echeck_payments": false,
            "block_non_us_payments": false,
            "block_unconfirmed_us_address_payments": true
        }
        """.data(using: .utf8)!
        let preference = try PaymentReceivingPreferences(
            blockUnconfirmedUSAddress: true,
            blockNonUS: false,
            blockEcheck: false,
            blockCrossCurrency: true,
            blockSendMoney: false,
            alternatePayment: "https://example.com/alternate",
            displayInstructionsInput: true,
            ccDescriptor: "NOT-SURE",
            ccDescriptorExtended: "NOTE-SURE-AGAIN"
        )
        
        try XCTAssertEqual(preference, decoder.decode(PaymentReceivingPreferences.self, from: json))
    }
    
    static var allTests: [(String, (PaymentReceivingPreferencesTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



