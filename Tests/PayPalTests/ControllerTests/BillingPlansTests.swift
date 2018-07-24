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
        try! services.register(PayPalProvider())
        
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
    
    func testListEndpoint()throws {
        let plans = try self.app.make(BillingPlans.self)
        let list = try plans.list(parameters: QueryParamaters(totalCountRequired: true)).wait()
        
        XCTAssertNotNil(list.items)
        XCTAssertNotNil(list.plans)
    }
    
    func testUpdateEndpoint()throws {
        let plans = try self.app.make(BillingPlans.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let status = try plans.update(plan: id, patches: [Patch(operation: .replace, path: "/name", value: "Vaser Moth")]).wait()
        
        XCTAssertEqual(status, .ok)
    }
    
    static var allTests: [(String, (BillingPlansTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testListEndpoint", testListEndpoint),
        ("testUpdateEndpoint", testUpdateEndpoint)
    ]
}

