import XCTest
@testable import PayPal

final class MerchantAccountTests: XCTestCase {
    func testInit()throws {
        let account = try MerchantAccount(
            owner: nil,
            business: nil,
            status: .a,
            currency: .usd,
            seconderyCurrencies: [],
            paymentReceiving: PaymentReceivingPreferences(),
            relations: [],
            permissions: [],
            timezone: .chicago,
            partnerExternalID: "F42E7896-17E3-455C-9B85-5F96729A4FD9",
            loginable: true,
            partnerTaxReporting: false,
            signupOptions: SignupOptions(partner: nil, legal: nil, web: nil, notification: nil),
            errors: [],
            financialInstruments: FinancialInstruments(instruments: nil)
        )
        
        XCTAssertNil(account.owner)
        XCTAssertNil(account.business)
        XCTAssertEqual(account.status, .a)
        XCTAssertEqual(account.seconderyCurrencies, [])
        XCTAssertEqual(account.relations, [])
        XCTAssertEqual(account.permissions, [])
        XCTAssertEqual(account.timezone, .chicago)
        XCTAssertEqual(account.partnerExternalID, "F42E7896-17E3-455C-9B85-5F96729A4FD9")
        XCTAssertEqual(account.loginable, true)
        XCTAssertEqual(account.partnerTaxReporting, false)
        XCTAssertEqual(account.signupOptions, SignupOptions(partner: nil, legal: nil, web: nil, notification: nil))
        XCTAssertEqual(account.errors, [])
        XCTAssertEqual(account.financialInstruments, FinancialInstruments(instruments: nil))
        try XCTAssertEqual(account.paymentReceiving, PaymentReceivingPreferences())
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(MerchantAccount(
            owner: nil,
            business: nil,
            status: .a,
            currency: nil,
            seconderyCurrencies: [],
            paymentReceiving: nil,
            relations: nil,
            permissions: nil,
            timezone: nil,
            partnerExternalID: String(repeating: "p", count: 128),
            loginable: nil,
            partnerTaxReporting: nil,
            signupOptions: nil,
            errors: [],
            financialInstruments: nil
        ))
        var account = try MerchantAccount(
            owner: nil,
            business: nil,
            status: .a,
            currency: nil,
            seconderyCurrencies: [],
            paymentReceiving: nil,
            relations: nil,
            permissions: nil,
            timezone: nil,
            partnerExternalID: String(repeating: "p", count: 127),
            loginable: nil,
            partnerTaxReporting: nil,
            signupOptions: nil,
            errors: [],
            financialInstruments: nil
        )
        
        try XCTAssertThrowsError(account.set(\MerchantAccount.partnerExternalID <~ String(repeating: "p", count: 128)))
        try account.set(\.partnerExternalID <~ "id")
        
        XCTAssertEqual(account.partnerExternalID, "id")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let account = try MerchantAccount(
            owner: nil,
            business: nil,
            status: .a,
            currency: .usd,
            seconderyCurrencies: [],
            paymentReceiving: PaymentReceivingPreferences(),
            relations: [],
            permissions: [],
            timezone: .chicago,
            partnerExternalID: "F42E7896-17E3-455C-9B85-5F96729A4FD9",
            loginable: true,
            partnerTaxReporting: false,
            signupOptions: SignupOptions(partner: nil, legal: nil, web: nil, notification: nil),
            errors: [],
            financialInstruments: FinancialInstruments(instruments: nil)
        )
        let generated = try String(data: encoder.encode(account), encoding: .utf8)!
        let json =
            "{\"account_status\":\"A\",\"secondary_currency\":[],\"partner_tax_reporting\":false," +
            "\"partner_merchant_external_id\":\"F42E7896-17E3-455C-9B85-5F96729A4FD9\",\"account_relations\":[],\"signup_options\":{}," +
            "\"account_currency\":\"USD\",\"account_permissions\":[],\"financial_instruments\":{},\"timezone\":\"America\\/Chicago\"," +
            "\"payment_receiving_preferences\":{},\"loginable\":true,\"errors\":[]}"
        
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
            "errors": [],
            "signup_options": {},
            "partner_tax_reporting": false,
            "loginable": true,
            "partner_merchant_external_id": "F42E7896-17E3-455C-9B85-5F96729A4FD9",
            "financial_instruments": {},
            "timezone": "America/Chicago",
            "account_permissions": [],
            "account_relations": [],
            "payment_receiving_preferences": {},
            "secondary_currency": [],
            "account_currency": "USD",
            "account_status": "A"
        }
        """.data(using: .utf8)!
        let account = try MerchantAccount(
            owner: nil,
            business: nil,
            status: .a,
            currency: .usd,
            seconderyCurrencies: [],
            paymentReceiving: PaymentReceivingPreferences(),
            relations: [],
            permissions: [],
            timezone: .chicago,
            partnerExternalID: "F42E7896-17E3-455C-9B85-5F96729A4FD9",
            loginable: true,
            partnerTaxReporting: false,
            signupOptions: SignupOptions(partner: nil, legal: nil, web: nil, notification: nil),
            errors: [],
            financialInstruments: FinancialInstruments(instruments: nil)
        )
        
        try XCTAssertEqual(account, decoder.decode(MerchantAccount.self, from: json))
    }
    
    static var allTests: [(String, (MerchantAccountTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




