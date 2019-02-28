import XCTest
import Failable
@testable import PayPal

final class BillingPlanTests: XCTestCase {
    func testInit()throws {
        let plan = try BillingPlan(
            name: .init("Monthly Water"),
            description: .init("Your water payment"),
            type: .infinite,
            payments: [
                BillingPayment(
                    name: .init("Water Charge"),
                    type: .regular,
                    interval: 1,
                    frequency: .month,
                    cycles: 0,
                    amount: CurrencyAmount(currency: .usd, value: 10.00),
                    charges: nil
                )
            ],
            preferances: nil
        )
        
        XCTAssertEqual(plan.id, nil)
        XCTAssertEqual(plan.state, nil)
        XCTAssertEqual(plan.created, nil)
        XCTAssertEqual(plan.updated, nil)
        XCTAssertEqual(plan.terms, nil)
        XCTAssertEqual(plan.currency, nil)
        XCTAssertEqual(plan.links, nil)
        XCTAssertEqual(plan.name.value, "Monthly Water")
        XCTAssertEqual(plan.description.value, "Your water payment")
        XCTAssertEqual(plan.type, .infinite)
        XCTAssertEqual(plan.preferances, nil)
        XCTAssertEqual(plan.payments?.count, 1)
        try XCTAssertEqual(plan.payments?.first, BillingPayment(
            name: .init("Water Charge"),
            type: .regular,
            interval: 1,
            frequency: .month,
            cycles: 0,
            amount: CurrencyAmount(currency: .usd, value: 10.00),
            charges: nil
        ))
    }
    
    func testValueValidation()throws {
        var plan = try BillingPlan(
            name: "Monthly Water",
            description: "Your water payment",
            type: .infinite,
            payments: [
                BillingPayment(
                    name: .init("Water Charge"),
                    type: .regular,
                    interval: 1,
                    frequency: .month,
                    cycles: 0,
                    amount: CurrencyAmount(currency: .usd, value: 10.00),
                    charges: nil
                )
            ],
            preferances: nil
        )
        
        try XCTAssertThrowsError(plan.name <~ String(repeating: "N", count: 129))
        try XCTAssertThrowsError(plan.description <~ String(repeating: "D", count: 129))
        
        try plan.name <~ "Electric"
        try plan.description <~ "Monthly Electricity Charge"
        
        XCTAssertEqual(plan.name.value, "Electric")
        XCTAssertEqual(plan.description.value, "Monthly Electricity Charge")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let plan = try BillingPlan(
            name: .init("Monthly Water"),
            description: .init("Your water payment"),
            type: .infinite,
            payments: [
                BillingPayment(
                    name: .init("Water Charge"),
                    type: .regular,
                    interval: 1,
                    frequency: .month,
                    cycles: 0,
                    amount: CurrencyAmount(currency: .usd, value: 10.00),
                    charges: nil
                )
            ],
            preferances: nil
        )
        let generated = try String(data: encoder.encode(plan), encoding: .utf8)!
        let json =
            "{\"payment_definitions\":[{\"frequency\":\"MONTH\",\"amount\":{\"currency\":\"USD\",\"value\":\"10.00\"},\"frequency_interval\":\"1\"," +
            "\"cycles\":\"0\",\"name\":\"Water Charge\",\"type\":\"REGULAR\"}],\"name\":\"Monthly Water\",\"type\":\"INFINITE\"," +
            "\"description\":\"Your water payment\"}"
        
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
        let idFail = """
        {
            "id": "\(String(repeating: "39174A3D-5B79-459C-8AD2-4AD8370636B7", count: 4))",
            "name": "The Plan",
            "description": "Can't Tell",
            "type": "FIXED"
        }
        """.data(using: .utf8)!
        let nameFail = """
        {
            "id": "39174A3D-5B79-459C-8AD2-4AD8370636B7",
            "name": "\(String(repeating: "N", count: 129))",
            "description": "Can't Tell",
            "type": "FIXED"
        }
        """.data(using: .utf8)!
        let descriptionFail = """
        {
            "id": "39174A3D-5B79-459C-8AD2-4AD8370636B7",
            "name": "The Plan",
            "description": "\(String(repeating: "N", count: 129))",
            "type": "FIXED"
        }
        """.data(using: .utf8)!
        let valid = """
        {
            "name": "The Plan",
            "description": "Can't Tell",
            "type": "FIXED"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(BillingPlan.self, from: idFail))
        try XCTAssertThrowsError(decoder.decode(BillingPlan.self, from: nameFail))
        try XCTAssertThrowsError(decoder.decode(BillingPlan.self, from: descriptionFail))
        try XCTAssertEqual(
            BillingPlan(
                name: .init("The Plan"),
                description: .init("Can't Tell"),
                type: .fixed,
                payments: nil,
                preferances: nil
            ),
            decoder.decode(BillingPlan.self, from: valid)
        )
    }
    
    static var allTests: [(String, (BillingPlanTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

