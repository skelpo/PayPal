import XCTest
@testable import PayPal

final class NewAgreementTests: XCTestCase {
    let now = Date().iso8601
    
    func testInit()throws {
        let agreement = try NewAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: now,
            payer: Payer(
                method: .paypal,
                fundingInstruments: nil,
                info: nil
            ),
            plan: BillingPlan(
                name: "Nia's Maggot Loaf",
                description: "Weekly maggot loaf subscription",
                type: .infinite,
                payments: nil,
                preferances: nil
            )
        )
        
        XCTAssertEqual(agreement.details, nil)
        XCTAssertEqual(agreement.shippingAddress, nil)
        XCTAssertEqual(agreement.overrideMerchantPreferances, nil)
        XCTAssertEqual(agreement.overrideChargeModels, nil)
        
        XCTAssertEqual(agreement.name, "Nia's Maggot Loaf")
        XCTAssertEqual(agreement.description, "Weekly maggot loaf subscription")
        XCTAssertEqual(agreement.start, now)
        XCTAssertEqual(agreement.payer, Payer(method: .paypal, fundingInstruments: nil, info: nil))
        try XCTAssertEqual(agreement.plan, BillingPlan(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            type: .infinite,
            payments: nil,
            preferances: nil
        ))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(NewAgreement(
            name: String(repeating: "n", count: 129),
            description: "Weekly maggot loaf subscription",
            start: now,
            payer: Payer(method: .paypal, fundingInstruments: nil, info: nil),
            plan: BillingPlan(name: "Nia's Maggot Loaf", description: "Weekly maggot loaf subscription", type: .infinite, payments: nil, preferances: nil)
        ))
        try XCTAssertThrowsError(NewAgreement(
            name: "Nia's Maggot Loaf",
            description: String(repeating: "d", count: 129),
            start: now,
            payer: Payer(method: .paypal, fundingInstruments: nil, info: nil),
            plan: BillingPlan(name: "Nia's Maggot Loaf", description: "Weekly maggot loaf subscription", type: .infinite, payments: nil, preferances: nil)
        ))
        
        var agreement = try NewAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: now,
            payer: Payer(method: .paypal, fundingInstruments: nil, info: nil),
            plan: BillingPlan(name: "Nia's Maggot Loaf", description: "Weekly maggot loaf subscription", type: .infinite, payments: nil, preferances: nil)
        )
        
        try XCTAssertThrowsError(agreement.set(\.name <~ String(repeating: "n", count: 129)))
        try XCTAssertThrowsError(agreement.set(\.description <~ String(repeating: "d", count: 129)))
        
        try agreement.set(\.name <~ "No Other Name")
        try agreement.set(\.description <~ "No other description")
        
        XCTAssertEqual(agreement.name, "No Other Name")
        XCTAssertEqual(agreement.description, "No other description")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let agreement = try NewAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: now,
            payer: Payer(
                method: .paypal,
                fundingInstruments: nil,
                info: nil
            ),
            plan: BillingPlan(
                name: "Nia's Maggot Loaf",
                description: "Weekly maggot loaf subscription",
                type: .infinite,
                payments: nil,
                preferances: nil
            )
        )
        let generated = try String(data: encoder.encode(agreement), encoding: .utf8)!
        let json =
            "{\"plan\":{\"name\":\"Nia's Maggot Loaf\",\"type\":\"INFINITE\",\"description\":\"Weekly maggot loaf subscription\"},\"start_date\":\"\(now)\"," +
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
        let agreement = try NewAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: now,
            payer: Payer(
                method: .paypal,
                fundingInstruments: nil,
                info: nil
            ),
            plan: BillingPlan(
                name: "Nia's Maggot Loaf",
                description: "Weekly maggot loaf subscription",
                type: .infinite,
                payments: nil,
                preferances: nil
            )
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
                "type": "INFINITE"
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
                "type": "INFINITE"
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
                "type": "INFINITE"
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(NewAgreement.self, from: nameFail))
        try XCTAssertThrowsError(decoder.decode(NewAgreement.self, from: descriptionFail))
        try XCTAssertEqual(agreement, decoder.decode(NewAgreement.self, from: json))
    }
    
    static var allTests: [(String, (NewAgreementTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


