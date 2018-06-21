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
        
        let config = Config.default()
        var services = Services.default()
        
        environment.arguments = ["vapor", "serve"]
        try! services.register(PayPal.Provider())
        
        let app = try! Application(config: config, environment: environment, services: services)
        self.app = app
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
        ("testConfigurationRegistered", testConfigurationRegistered)
    ]
}

