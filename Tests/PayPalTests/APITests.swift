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
        
        XCTAssertEqual(response["user_id"], "https://www.paypal.com/webapps/auth/identity/user/eEp3Op59PkxkjwQsK0LkDnv5d7JHwToZs0OkwVcjAZM")
    }
    
    static var allTests: [(String, (APITests) -> ()throws -> ())] = [
        ("testAPIHelper", testAPIHelper)
    ]
}


