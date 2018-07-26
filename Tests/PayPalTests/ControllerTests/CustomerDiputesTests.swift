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
    
    func testAcceptEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get dispute ID")
        }
        
        let body = try AcceptDisputeBody(
            note: "Refund to customer",
            reason: .policy,
            invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
            returnAddress: nil,
            refund: Money(currency: .usd, value: "55.50")
        )
        let links = try disputes.accept(claim: id, with: body).wait()
        
        XCTAssertGreaterThan(links.count, 0)
        XCTAssertEqual(links.first?.href, "https://api.sandbox.paypal.com/v1/customer/disputes/" + id)
    }
    
    func testSettleEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get dispute ID")
        }
        
        let links = try disputes.settle(dispute: id, outcome: .buyer).wait()
        
        XCTAssertGreaterThan(links.count, 0)
        XCTAssertEqual(links.first?.href, "https://api.sandbox.paypal.com/v1/customer/disputes/" + id)
    }
    
    static var allTests: [(String, (CustomerDisputesTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testListEndpoint", testListEndpoint),
        ("testDetailsEndpoint", testDetailsEndpoint),
        ("testAcceptEndpoint", testAcceptEndpoint),
        ("testSettleEndpoint", testSettleEndpoint)
    ]
}


