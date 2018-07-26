import XCTest
import Vapor
@testable import PayPal

final class ActivitiesTests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
    }
    
    func testServiceExists()throws {
        _ = try app.make(Activities.self)
    }
    
    func testActivitiesEndpoint()throws {
        let activities = try app.make(Activities.self)
        
        let plain = try activities.activities().wait()
        let queried = try activities.activities(parameters: QueryParamaters(startTime: Date.distantPast, endTime: Date())).wait()
        
        XCTAssert(plain.items!.count > 0, "plain.items count is 0")
        XCTAssert(queried.items!.count > 0, "queried.items count is 0")
    }
    
    static var allTests: [(String, (ActivitiesTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testActivitiesEndpoint", testActivitiesEndpoint)
    ]
}

