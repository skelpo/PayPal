import XCTest
import Vapor
@testable import PayPal

final class ManagedAccountsTests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
    }
    
    func testServiceExists()throws {
        _ = try app.make(ManagedAccounts.self)
    }
    
    static var allTests: [(String, (ManagedAccountsTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists)
    ]
}

