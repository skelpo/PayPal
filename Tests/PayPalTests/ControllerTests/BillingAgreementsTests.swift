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
        try! services.register(PayPal.Provider())
        
        app = try! Application.testable(services: services)
    }
    
    func testServiceExists()throws {
        _ = try app.make(BillingAgreements.self)
    }
    
    func testCreateEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        let new = try NewAgreement(
            name: "Nia's Maggot Loaf",
            description: "Weekly maggot loaf subscription",
            start: Date().iso8601,
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
        
        let agreement = try agreements.create(with: new).wait()
        
        XCTAssertNotEqual(agreement.id, nil)
        XCTAssertEqual(agreement.name, "Nia's Maggot Loaf")
        
        self.id = agreement.id
    }
    
    func testUpdateEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get agreement ID to update")
        }
        
        let patch = try Patch(operation: .replace, path: "/name", value: "Igby Maggot")
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
    
    static var allTests: [(String, (BillingAgreementsTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testUpdateEndpoint", testUpdateEndpoint),
        ("testGetEndpoint", testGetEndpoint),
        ("testBillBalanceEndpoint", testBillBalanceEndpoint),
        ("testCancelEndpoint", testCancelEndpoint),
        ("testReactivationEndpoint", testReactivationEndpoint)
    ]
}

