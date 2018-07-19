import XCTest
@testable import PayPal

final class BillingAgreementTests: XCTestCase {
    let now = Date().iso8601
    
    func testInit()throws {
       let agreement = try BillingAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: self.now,
            details: nil,
            payer: Payer(method: .paypal, fundingInstruments: nil, info: nil),
            shippingAddress: nil,
            overrideMerchantPreferances: nil,
            overrideChargeModels: nil,
            plan: Plan(name: "Nia's Maggot Loaf", description: "Weekly maggot loaf subscription", type: .infinate, payments: nil, preferances: nil)
        )
        
        XCTAssertEqual(agreement.id, nil)
        XCTAssertEqual(agreement.state, nil)
        XCTAssertEqual(agreement.links, nil)
        XCTAssertEqual(agreement.details, nil)
        XCTAssertEqual(agreement.shippingAddress, nil)
        XCTAssertEqual(agreement.overrideMerchantPreferances, nil)
        XCTAssertEqual(agreement.overrideChargeModels, nil)
        
        XCTAssertEqual(agreement.name, "Nia's Maggot Loaf")
        XCTAssertEqual(agreement.description, "Weekly maggot loaf subscription")
        XCTAssertEqual(agreement.start, now)
        XCTAssertEqual(agreement.payer, Payer(method: .paypal, fundingInstruments: nil, info: nil))
        try XCTAssertEqual(agreement.plan, Plan(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            type: .infinate,
            payments: nil,
            preferances: nil
        ))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(BillingAgreement(
            name: String(repeating: "n", count: 129),
            description: "Weekly maggot loaf subscription",
            start: self.now,
            details: nil,
            payer: Payer(method: .paypal, fundingInstruments: nil, info: nil),
            shippingAddress: nil,
            overrideMerchantPreferances: nil,
            overrideChargeModels: nil,
            plan: Plan(name: "Nia's Maggot Loaf", description: "Weekly maggot loaf subscription", type: .infinate, payments: nil, preferances: nil)
        ))
        try XCTAssertThrowsError(BillingAgreement(
            name: "Nia's Maggot Loaf",
            description: String(repeating: "d", count: 129),
            start: self.now,
            details: nil,
            payer: Payer(method: .paypal, fundingInstruments: nil, info: nil),
            shippingAddress: nil,
            overrideMerchantPreferances: nil,
            overrideChargeModels: nil,
            plan: Plan(name: "Nia's Maggot Loaf", description: "Weekly maggot loaf subscription", type: .infinate, payments: nil, preferances: nil)
        ))
        
        var agreement = try BillingAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: self.now,
            details: nil,
            payer: Payer(method: .paypal, fundingInstruments: nil, info: nil),
            shippingAddress: nil,
            overrideMerchantPreferances: nil,
            overrideChargeModels: nil,
            plan: Plan(name: "Nia's Maggot Loaf", description: "Weekly maggot loaf subscription", type: .infinate, payments: nil, preferances: nil)
        )
        
        try XCTAssertThrowsError(agreement.set(\BillingAgreement.name <~ String(repeating: "n", count: 129)))
        try XCTAssertThrowsError(agreement.set(\BillingAgreement.description <~ String(repeating: "d", count: 129)))
        
        try agreement.set(\.name <~ "No Other Name")
        try agreement.set(\.description <~ "No other description")
        
        XCTAssertEqual(agreement.name, "No Other Name")
        XCTAssertEqual(agreement.description, "No other description")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let agreement = try BillingAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: self.now,
            details: nil,
            payer: Payer(method: .paypal, fundingInstruments: nil, info: nil),
            shippingAddress: nil,
            overrideMerchantPreferances: nil,
            overrideChargeModels: nil,
            plan: Plan(name: "Nia's Maggot Loaf", description: "Weekly maggot loaf subscription", type: .infinate, payments: nil, preferances: nil)
        )
        let generated = try String(data: encoder.encode(agreement), encoding: .utf8)!
        let json =
            "{\"plan\":{\"name\":\"Nia's Maggot Loaf\",\"type\":\"INFINATE\",\"description\":\"Weekly maggot loaf subscription\"},\"start_date\":\"\(now)\"," +
        "\"name\":\"Nia's Maggot Loaf\",\"description\":\"Weekly maggot loaf subscription\",\"payer\":{\"payment_method\":\"paypal\"}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let agreement = try BillingAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: self.now,
            details: nil,
            payer: Payer(method: .paypal, fundingInstruments: nil, info: nil),
            shippingAddress: nil,
            overrideMerchantPreferances: nil,
            overrideChargeModels: nil,
            plan: Plan(name: "Nia's Maggot Loaf", description: "Weekly maggot loaf subscription", type: .infinate, payments: nil, preferances: nil)
        )
        
        let json = """
        {
            "name": "Nia's Maggot Loaf",
            "description": "Weekly maggot loaf subscription",
            "start_date": "\(now)",
            "payer": {
                "payment_method": "paypal"
            },
            "plan": {
                "name": "Nia's Maggot Loaf",
                "description": "Weekly maggot loaf subscription",
                "type": "INFINATE"
            }
        }
        """.data(using: .utf8)!
        let nameFail = """
        {
            "name": "\(String(repeating: "n", count: 129))",
            "description": "Weekly maggot loaf subscription",
            "start_date": "\(now)",
            "payer": {
                "payment_method": "paypal"
            },
            "plan": {
                "name": "Nia's Maggot Loaf",
                "description": "Weekly maggot loaf subscription",
                "type": "INFINATE"
            }
        }
        """.data(using: .utf8)!
        let descriptionFail = """
        {
            "name": "Nia's Maggot Loaf",
            "description": "\(String(repeating: "d", count: 129))",
            "start_date": "\(now)",
            "payer": {
                "payment_method": "paypal"
            },
            "plan": {
                "name": "Nia's Maggot Loaf",
                "description": "Weekly maggot loaf subscription",
                "type": "INFINATE"
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(BillingAgreement.self, from: nameFail))
        try XCTAssertThrowsError(decoder.decode(BillingAgreement.self, from: descriptionFail))
        try XCTAssertEqual(agreement, decoder.decode(BillingAgreement.self, from: json))
    }
    
    static var allTests: [(String, (BillingAgreementTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



