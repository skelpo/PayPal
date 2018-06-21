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
        try! app.asyncRun().wait()
        self.app = app
    }
    
    func testBootSucceeds()throws {}
    
    static var allTests: [(String, (ProviderTests) -> ()throws -> ())] = [
        ("testBootSucceeds", testBootSucceeds)
    ]
}

