import XCTest
import Vapor
@testable import PayPal

final class BillingAgreementsTests: XCTestCase {
    
    var app: Application!
    
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
    }
    
    static var allTests: [(String, (BillingAgreementsTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint)
    ]
}

