import XCTest
import Vapor
@testable import PayPal

final class ProviderTests: XCTestCase {
    var environment: Vapor.Environment = .testing
    var app: Application!
    
    override func setUp() {
        super.setUp()
        
        setenv("PAYPAL_CLIENT_ID", "fake_paypal_id", 1)
        setenv("PAYPAL_CLIENT_SECRET", "fake_paypal_secret", 1)
        
        var services = Services.default()
        try! services.register(PayPal.Provider())
        
        self.app = try! Application.testable(services: services, environment: self.environment)
    }
    
    func testBootSucceeds()throws {
        try app.asyncRun().wait()
        try app.syncShutdownGracefully()
    }
    
    func testConfigurationRegistered()throws {
        _ = try app.make(PayPal.Configuration.self)
    }
    
    func testConfigurationHasExpectedValues()throws {
        var config = try app.make(PayPal.Configuration.self)
        _ = try app.make(PayPalClient.self)
        
        XCTAssertEqual(config.environment, .sandbox)
        XCTAssertEqual(config.id, "fake_paypal_id")
        XCTAssertEqual(config.secret, "fake_paypal_secret")
        
        self.environment = .production
        self.tearDown()
        self.setUp()
        config = try app.make(PayPal.Configuration.self)
        
        XCTAssertEqual(config.environment, .production)
        self.environment = .testing
    }
    
    static var allTests: [(String, (ProviderTests) -> ()throws -> ())] = [
        ("testBootSucceeds", testBootSucceeds),
        ("testConfigurationRegistered", testConfigurationRegistered),
        ("testConfigurationHasExpectedValues", testConfigurationHasExpectedValues)
    ]
}

