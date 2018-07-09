import XCTest
import Vapor
@testable import PayPal

final class APITests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPal.Provider())
        
        app = try! Application.testable(services: services)
    }
    
    func testAPIHelper()throws {
        let response = try app.paypal(.GET, "v1/oauth2/token/userinfo?schema=openid", as: [String: String].self).wait()
        
        XCTAssertEqual(response["street_address"], "1 Main St San Jose")
        XCTAssertEqual(response["region"], "CA")
        XCTAssertEqual(response["postal_code"], "95131")
        XCTAssertEqual(response["country"], "US")
    }
    
    static var allTests: [(String, (APITests) -> ()throws -> ())] = [
        ("testAPIHelper", testAPIHelper)
    ]
}


