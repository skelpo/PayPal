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
    
    static var allTests: [(String, (BillingPlansTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists)
    ]
}

