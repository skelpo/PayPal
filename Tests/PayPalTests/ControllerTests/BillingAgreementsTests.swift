import XCTest
import Vapor
@testable import PayPal

final class BillingAgreementsTests: XCTestCase {
    
    var app: Application!
    var id: String!
    
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
        
        let patch = try Patch(operation: .replace, path: "/name", value: "Igby Maggot")
        let updated = try agreements.update(agreement: self.id, with: [patch]).wait()
        
        XCTAssertEqual(updated, .ok)
    }
    
    func testGetEndpoint()throws {
        let agreements = try app.make(BillingAgreements.self)
        let agreement = try agreements.get(agreement: self.id).wait()
        
        XCTAssertNotEqual(agreement.id, nil)
        XCTAssert(agreement.name == "Nia's Maggot Loaf" || agreement.name == "Igby Maggot")
    }
    
    static var allTests: [(String, (BillingAgreementsTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testUpdateEndpoint", testUpdateEndpoint),
        ("testGetEndpoint", testGetEndpoint)
    ]
}

