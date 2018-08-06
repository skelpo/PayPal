import XCTest
import Vapor
@testable import PayPal

final class BillingAgreementsTests: XCTestCase {
    
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
        _ = try app.make(BillingAgreements.self)
    }
    
    func testCreateEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let plan = try app.make(BillingPlans.self).list(state: .active).wait().plans?.first else {
            throw Abort(.internalServerError, reason: "No billing plan found")
        }
        guard let id = plan.id else {
            throw Abort(.internalServerError, reason: "Billing plan missing ID")
        }
        
        let new = try NewAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: (Date() + 60 * 60 * 24).iso8601,
            payer: Payer(
                method: .paypal,
                fundingInstruments: nil,
                info: nil
            ),
            plan: ID(id)
        )
        
        let agreement = try agreements.create(with: new).wait()
        
        XCTAssertEqual(agreement.name, "Nia's Maggot Loaf")
    }
    
    func testUpdateEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to update")
        }
        
        let patch = try Patch(operation: .replace, path: "/", value: ["name": "Igby Maggot"])
        let updated = try agreements.update(agreement: id, with: [patch]).wait()
        
        XCTAssertEqual(updated, .ok)
    }
    
    func testGetEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let agreement = try agreements.get(agreement: id).wait()
        
        XCTAssertNotEqual(agreement.id, nil)
        XCTAssert(agreement.name == "Nia's Maggot Loaf" || agreement.name == "Igby Maggot")
    }
    
    func testBillBalanceEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let status = try agreements.billBalance(for: id, reason: "Monthly billing").wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testCancelEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let status = try agreements.cancel(agreement: id, reason: "Out of maggots").wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testReactivationEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let status = try agreements.reactivate(agreement: id, reason: "Found a boatload of maggots.").wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testSetBalanaceEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let status = try agreements.setBalance(for: id, amount: .init(currency: .usd, value: "1000")).wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testSusupendEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let status = try agreements.suspend(agreement: id, reason: "Nia kidnapped").wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testTransactionsEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let transactions = try agreements.transactions(for: id).wait()
        
        XCTAssertGreaterThan(transactions.count, 0)
    }
    
    func testExecuteEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to get")
        }
        
        let details = try agreements.execute(agreement: id).wait()
        
        XCTAssertNotEqual(details.id, id)
    }
    
    static var allTests: [(String, (BillingAgreementsTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testUpdateEndpoint", testUpdateEndpoint),
        ("testGetEndpoint", testGetEndpoint),
        ("testBillBalanceEndpoint", testBillBalanceEndpoint),
        ("testCancelEndpoint", testCancelEndpoint),
        ("testReactivationEndpoint", testReactivationEndpoint),
        ("testSetBalanaceEndpoint", testSetBalanaceEndpoint),
        ("testSusupendEndpoint", testSusupendEndpoint),
        ("testTransactionsEndpoint", testTransactionsEndpoint),
        ("testExecuteEndpoint", testExecuteEndpoint)
    ]
}

