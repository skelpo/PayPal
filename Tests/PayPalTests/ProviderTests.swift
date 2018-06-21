import XCTest
import Vapor
@testable import PayPal

final class ProviderTests: XCTestCase {
    var app: Application!
    
    override func setUp() {
        super.setUp()
        
        let config = Config.default()
        var services = Services.default()
        var environment = Environment.testing
        
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
    
    static var allTests: [(String, (ProviderTests) -> ()throws -> ())] = [
        ("testBootSucceeds", testBootSucceeds),
        ("testConfigurationRegistered", testConfigurationRegistered)
    ]
}

