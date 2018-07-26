import XCTest
import Vapor
@testable import PayPal

final class CustomerDisputesTests: XCTestCase {
    
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
        _ = try app.make(CustomerDisputes.self)
    }
    
    static var allTests: [(String, (CustomerDisputesTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
    ]
}


