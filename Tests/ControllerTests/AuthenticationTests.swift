import XCTest
import Vapor
@testable import PayPal

public final class AuthenticationTests: XCTestCase {
    
    var app: Application!
    
    override public func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
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
    
    public static var allTests: [(String, (AuthenticationTests) -> ()throws -> ())] = [
        ("testTokenExpired", testTokenExpired),
        ("testAPIAuthentication", testAPIAuthentication)
    ]
}

