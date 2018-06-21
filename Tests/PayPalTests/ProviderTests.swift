import XCTest
import Vapor
@testable import PayPal

final class ProviderTests: XCTestCase {
    func testBootSucceeds()throws {
        var services = Services.default()
        let config = Config.default()
        let environment = Environment.development
        
        try services.register(PayPal.Provider())
        
        try Application(config: config, environment: environment, services: services).asyncRun().wait()
    }
    
    static var allTests: [(String, (ProviderTests) -> ()throws -> ())] = [
        ("testBootSucceeds", testBootSucceeds)
    ]
}

