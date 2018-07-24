import XCTest
import Vapor
@testable import PayPal

final class BillingPlansTests: XCTestCase {
    
    var app: Application!
    var id: String?
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPal.Provider())
        
        app = try! Application.testable(services: services)
    }
    
    func testServiceExists()throws {
        _ = try app.make(BillingPlans.self)
    }
    
    func testCreateEndpoint()throws {
        let plans = try self.app.make(BillingPlans.self)
        let plan = try BillingPlan(
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
        
        let created = try plans.create(with: plan).wait()
        self.id = created.id
        
        XCTAssertEqual(created.name, plan.name)
        XCTAssertNotNil(created.id)
    }
    
    static var allTests: [(String, (BillingPlansTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint)
    ]
}

