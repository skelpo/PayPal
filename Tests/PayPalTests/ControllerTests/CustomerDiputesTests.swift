import XCTest
import Vapor
@testable import PayPal

final class CustomerDisputesTests: XCTestCase {
    
    var app: Application!
    var id: String?
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
    }
    
    func testServiceExists()throws {
        _ = try app.make(CustomerDisputes.self)
    }
    
    func testListEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        let _ = try disputes.list().wait()
    }
    
    func testDetailsEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get dispute ID")
        }
        
        let details = try disputes.details(for: id).wait()
        
        XCTAssertEqual(details.id, id)
    }
    
    static var allTests: [(String, (CustomerDisputesTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testListEndpoint", testListEndpoint),
        ("testDetailsEndpoint", testDetailsEndpoint)
    ]
}


