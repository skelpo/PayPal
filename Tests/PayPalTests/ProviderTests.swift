import XCTest
import Vapor
@testable import PayPal

final class ProviderTests: XCTestCase {
    func testBootSucceeds()throws {
        let config = Config.default()
        var services = Services.default()
        var environment = Environment.testing
        
        environment.arguments = ["vapor", "serve"]
        try services.register(PayPal.Provider())
        
        try Application(config: config, environment: environment, services: services).asyncRun().wait()
    }
    
    static var allTests: [(String, (ProviderTests) -> ()throws -> ())] = [
        ("testBootSucceeds", testBootSucceeds)
    ]
}

