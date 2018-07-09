import XCTest
import Vapor
@testable import PayPal

final class AuthenticationTests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        
        setenv("PAYPAL_CLIENT_ID", "fake_paypal_id", 1)
        setenv("PAYPAL_CLIENT_SECRET", "fake_paypal_secret", 1)
        
        var services = Services.default()
        try! services.register(PayPal.Provider())
        
        app = try! Application.testable(services: services)
    }
    
    func testTokenExpired() {
        let info = AuthInfo()
        XCTAssert(info.tokenExpired == true)
    }
    
    func testAPIAuthentication()throws {
        let client = try app.make(PayPalClient.self)
        try client.authenticate().wait()
        
        let auth = try app.make(AuthInfo.self)
        
        XCTAssert(auth.token != nil)
        XCTAssert(auth.appID != nil)
        XCTAssert(auth.expiresAt != nil)
        XCTAssert(auth.scopes.count > 0)
        XCTAssertEqual(auth.type, "Bearer")
        XCTAssertEqual(auth.tokenExpired, false)
    }
    
    static var allTests: [(String, (AuthenticationTests) -> ()throws -> ())] = [
        ("testTokenExpired", testTokenExpired),
        ("testAPIAuthentication", testAPIAuthentication)
    ]
}

