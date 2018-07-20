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
    
    static var allTests: [(String, (BillingAgreementsTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists)
    ]
}

