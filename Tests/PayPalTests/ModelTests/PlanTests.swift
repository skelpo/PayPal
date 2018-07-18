import XCTest
@testable import PayPal

final class PlanTests: XCTestCase {
    func testInit()throws {
        let plan = try Plan(
            name: "Monthly Water",
            description: "Your water payment",
            type: .infinate,
            payments: [
                Payment(
                    name: "Water Charge",
                    type: .regular,
                    interval: "1",
                    frequency: .month,
                    cycles: "0",
                    amount: Money(currency: .usd, value: "10.00"),
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
        XCTAssertEqual(plan.name, "Monthly Water")
        XCTAssertEqual(plan.description, "Your water payment")
        XCTAssertEqual(plan.type, .infinate)
        XCTAssertEqual(plan.preferances, nil)
        XCTAssertEqual(plan.paymentDefinitions?.count, 1)
        try XCTAssertEqual(plan.paymentDefinitions?.first, Payment(
            name: "Water Charge",
            type: .regular,
            interval: "1",
            frequency: .month,
            cycles: "0",
            amount: Money(currency: .usd, value: "10.00"),
            charges: nil
        ))
    }
    
    func testValueValidation()throws {
        try XCTAssertThrowsError(Plan(
            name: String(repeating: "N", count: 129),
            description: "Your water payment",
            type: .infinate,
            payments: nil,
            preferances: nil
        ))
        try XCTAssertThrowsError(Plan(
            name: "Monthly Water",
            description: String(repeating: "N", count: 129),
            type: .infinate,
            payments: nil,
            preferances: nil
        ))
        
        var plan = try Plan(
            name: "Monthly Water",
            description: "Your water payment",
            type: .infinate,
            payments: [
                Payment(
                    name: "Water Charge",
                    type: .regular,
                    interval: "1",
                    frequency: .month,
                    cycles: "0",
                    amount: Money(currency: .usd, value: "10.00"),
                    charges: nil
                )
            ],
            preferances: nil
        )
        
        try XCTAssertThrowsError(plan.set(\.name <~ String(repeating: "N", count: 129)))
        try XCTAssertThrowsError(plan.set(\.description <~ String(repeating: "D", count: 129)))
        
        try plan.set(\.name <~ "Electric")
        try plan.set(\.description <~ "Monthly Electricity Charge")
        plan.type = .fixed
        
        XCTAssertEqual(plan.name, "Electric")
        XCTAssertEqual(plan.description, "Monthly Electricity Charge")
        XCTAssertEqual(plan.type, .fixed)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let plan = try Plan(
            name: "Monthly Water",
            description: "Your water payment",
            type: .infinate,
            payments: [
                Payment(
                    name: "Water Charge",
                    type: .regular,
                    interval: "1",
                    frequency: .month,
                    cycles: "0",
                    amount: Money(currency: .usd, value: "10.00"),
                    charges: nil
                )
            ],
            preferances: nil
        )
        let generated = try String(data: encoder.encode(plan), encoding: .utf8)!
        let json =
            "{\"payment_definitions\":[{\"cycles\":\"0\",\"amount\":{\"value\":\"10.00\",\"currency_code\":\"USD\"},\"frequency_interval\":\"1\"," +
            "\"name\":\"Water Charge\",\"type\":\"REGULAR\",\"frequency\":\"MONTH\"}],\"name\":\"Monthly Water\",\"type\":\"INFINATE\"," +
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
        
        try XCTAssertThrowsError(decoder.decode(Plan.self, from: idFail))
        try XCTAssertThrowsError(decoder.decode(Plan.self, from: nameFail))
        try XCTAssertThrowsError(decoder.decode(Plan.self, from: descriptionFail))
        try XCTAssertEqual(
            Plan(
                name: "The Plan",
                description: "Can't Tell",
                type: .fixed,
                payments: nil,
                preferances: nil
            ),
            decoder.decode(Plan.self, from: valid)
        )
    }
    
    static var allTests: [(String, (PlanTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

