import XCTest
@testable import PayPal

public final class BillingPlanListTests: XCTestCase {
    func testInit()throws {
        let list = try BillingPlan.List(plans: [
            BillingPlan(
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
        ])
        
        XCTAssertEqual(list.items, "1")
        XCTAssertEqual(list.plans?.count, 1)
        try XCTAssertEqual(list.plans?.first,  BillingPlan(
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
        ))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let list = try BillingPlan.List(plans: [
            BillingPlan(
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
            ])
        let generated = try String(data: encoder.encode(list), encoding: .utf8)!
        let json =
            "{\"plans\":[{\"payment_definitions\":[{\"frequency\":\"MONTH\",\"amount\":{\"currency\":\"USD\",\"value\":\"10\"}," +
            "\"frequency_interval\":\"1\",\"cycles\":\"0\",\"name\":\"Water Charge\",\"type\":\"REGULAR\"}],\"name\":\"Monthly Water\"," +
            "\"type\":\"INFINITE\",\"description\":\"Your water payment\"}],\"total_items\":\"1\"}"
        
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
            "total_pages": "1",
            "total_items": "1",
            "links": [],
            "plans": [
                {
                    "payment_definitions": [
                        {
                            "cycles": "0",
                            "amount": {
                                "value": "10",
                                "currency": "USD"
                            },
                            "frequency_interval": "1",
                            "name": "Water Charge",
                            "type": "REGULAR",
                            "frequency": "MONTH"
                        }
                    ],
                    "name": "Monthly Water",
                    "type": "INFINITE",
                    "description": "Your water payment"
                }
            ]
        }
        """.data(using: .utf8)!
        let plan = try decoder.decode(BillingPlan.List.self, from: json)
        
        XCTAssertEqual(plan.pages, "1")
        XCTAssertEqual(plan.items, "1")
        XCTAssertEqual(plan.links, [])
        XCTAssertEqual(plan.plans?.count, 1)
        try XCTAssertEqual(plan.plans?.first, BillingPlan(
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
        ))
    }
    
    public static var allTests: [(String, (BillingPlanListTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


