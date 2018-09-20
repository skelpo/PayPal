import XCTest
import Vapor
@testable import PayPal

final class OrdersTests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
    }
    
    func testServiceExists()throws {
        _ = try app.make(Orders.self)
    }
    
    static var allTests: [(String, (OrdersTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists)
    ]
}

