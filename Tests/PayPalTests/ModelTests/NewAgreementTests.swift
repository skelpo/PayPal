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
            plan: Plan(
                name: "Nia's Maggot Loaf",
                description: "Weekly maggot loaf subscription",
                type: .infinate,
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
        try XCTAssertEqual(agreement.plan, Plan(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            type: .infinate,
            payments: nil,
            preferances: nil
        ))
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
            plan: Plan(
                name: "Nia's Maggot Loaf",
                description: "Weekly maggot loaf subscription",
                type: .infinate,
                payments: nil,
                preferances: nil
            )
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
        let agreement = try NewAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: now,
            payer: Payer(
                method: .paypal,
                fundingInstruments: nil,
                info: nil
            ),
            plan: Plan(
                name: "Nia's Maggot Loaf",
                description: "Weekly maggot loaf subscription",
                type: .infinate,
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
                "type": "INFINATE"
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(agreement, decoder.decode(NewAgreement.self, from: json))
    }
    
    static var allTests: [(String, (NewAgreementTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


