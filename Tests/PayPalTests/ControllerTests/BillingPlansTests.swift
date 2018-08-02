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
        
        let plans = try! self.app.make(BillingPlans.self)
        let list = try! plans.list(parameters: QueryParamaters(totalCountRequired: true)).wait()
        self.id = list.plans?.first?.id
    }
    
    func testServiceExists()throws {
        _ = try app.make(BillingPlans.self)
    }
    
    func testCreateEndpoint()throws {
        let plans = try self.app.make(BillingPlans.self)
        let plan = try BillingPlan(
            name: "Monthly Water",
            description: "Your water payment",
            type: .infinite,
            payments: [
                Payment(
                    name: "Water Charge",
                    type: .regular,
                    interval: "1",
                    frequency: .month,
                    cycles: "0",
                    amount: Amount(currency: .usd, value: "10.00"),
                    charges: nil
                )
            ],
            preferances: MerchantPreferances(
                setupFee: nil,
                cancelURL: "https://skelpo.com",
                returnURL: "https://skelpo.com",
                autoBill: .yes,
                initialFailAction: .cancel,
                acceptedPaymentType: nil,
                charSet: nil
            )
        )
        
        let created = try plans.create(with: plan).wait()
        
        XCTAssertEqual(created.name, plan.name)
        XCTAssertNotNil(created.id)
    }
    
    func testListEndpoint()throws {
        let plans = try self.app.make(BillingPlans.self)
        let list = try plans.list(parameters: QueryParamaters(totalCountRequired: true)).wait()
        
        XCTAssertNotNil(list.plans)
    }
    
    func testUpdateEndpoint()throws {
        let plans = try self.app.make(BillingPlans.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let status = try plans.update(plan: id, patches: [Patch(operation: .replace, path: "/", value: ["name": "Vaser Moth"])]).wait()
        
        XCTAssertEqual(status, .ok)
    }
    
    func testDetailsEndpoint()throws {
        let plans = try self.app.make(BillingPlans.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let details = try plans.details(plan: id).wait()
        
        XCTAssertEqual(details.id, id)
    }
    
    static var allTests: [(String, (BillingPlansTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testListEndpoint", testListEndpoint),
        ("testUpdateEndpoint", testUpdateEndpoint),
        ("testDetailsEndpoint", testDetailsEndpoint)
    ]
}

