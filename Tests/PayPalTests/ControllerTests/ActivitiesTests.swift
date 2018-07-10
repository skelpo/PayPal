import XCTest
import Vapor
@testable import PayPal

final class ActivitiesTests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPal.Provider())
        
        app = try! Application.testable(services: services)
    }
    
    static var allTests: [(String, (ActivitiesTests) -> ()throws -> ())] = []
}

