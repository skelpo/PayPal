import XCTest
import Vapor
@testable import NIO
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
        
        let disputes = try! self.app.make(CustomerDisputes.self)
        let list = try! disputes.list().wait()
        self.id = list.items?.first?.id
    }
    
    func testServiceExists()throws {
        _ = try app.make(CustomerDisputes.self)
    }
    
    func testListEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        let list = try disputes.list().wait()
        
        XCTAssertGreaterThan(list.items?.count ?? 0, 0)
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
    
    func testAppealEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get dispute ID")
        }
        
        let evidence = try Evidence(
            type: .proofOfFulfillment,
            info: Evidence.Info(
                tracking: [
                    Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
                ],
                refunds: [
                    "2F214F48-2651-498B-9D06-150BF00E85DA"
                ]
            ),
            documents: [Document(name: "README.md", size: "65kb")],
            notes: "I win. Ha!",
            itemID: "4FB4018C-F925-4FC6-B44B-0174C1B59F17"
        )
        let links = try disputes.appeal(dispute: id, evidence: [evidence]).wait()
        
        XCTAssertGreaterThan(links.count, 0)
        XCTAssertEqual(links.first?.href, "https://api.sandbox.paypal.com/v1/customer/disputes/" + id)
    }
    
    func testEscalateEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get dispute ID")
        }
        
        let links = try disputes.escalate(dispute: id, note: "A note to notice").wait()
        
        XCTAssertGreaterThan(links.count, 0)
        XCTAssertEqual(links.first?.href, "https://api.sandbox.paypal.com/v1/customer/disputes/" + id)
    }
    
    func testOfferEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get dispute ID")
        }
        
        let offer = try CustomerDispute.ResolutionOffer(
            note: "Offer refund with replacement item.",
            amount: Money(currency: .usd, value: "23"),
            type: .replacement,
            returnAddress: nil,
            invoiceID: nil
        )
        let links = try disputes.offerResolution(for: id, offer: offer).wait()
        
        XCTAssertGreaterThan(links.count, 0)
        XCTAssertEqual(links.first?.href, "https://api.sandbox.paypal.com/v1/customer/disputes/" + id)
    }
    
    func testEvidenceEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get dispute ID")
        }
        
        let pdf = try self.file()
        let evidence = try Evidence(
            type: .proofOfFulfillment,
            info: Evidence.Info(
                tracking: [
                    Tracking(carrier: .fedex, other: nil, url: nil, number: "9163524667210796186056")
                ],
                refunds: nil
            ),
            documents: nil,
            notes: "I win. Ha!",
            itemID: nil
        )
        let links = try disputes.evidence(for: id, file: pdf, evidences: [evidence]).wait()
        
        XCTAssertGreaterThan(links.count, 0)
        XCTAssertEqual(links.first?.href, "https://api.sandbox.paypal.com/v1/customer/disputes/" + id)
    }
    
    func testUpdateStatusEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get dispute ID")
        }
        
        let links = try disputes.updateStatus(of: id, with: .seller).wait()
        
        XCTAssertGreaterThan(links.count, 0)
        XCTAssertEqual(links.first?.href, "https://api.sandbox.paypal.com/v1/customer/disputes/" + id)
    }
    
    func testMessageEndpoint()throws {
        let disputes = try self.app.make(CustomerDisputes.self)
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "Cannot get dispute ID")
        }
        
        let links = try disputes.message(dispute: id, content: "De item haz ben ship").wait()
        
        XCTAssertGreaterThan(links.count, 0)
        XCTAssertEqual(links.first?.href, "https://api.sandbox.paypal.com/v1/customer/disputes/" + id)
    }
    
    func getPDF()throws -> String {
        if #available(OSX 10.12, *) {
            let home = FileManager.default.homeDirectoryForCurrentUser.relativePath
            guard let enumerator = FileManager.default.enumerator(atPath: home)?.allObjects as? [String] else {
                throw Abort(.internalServerError)
            }
            guard let path = enumerator.lazy.filter({ $0.contains("PayPal/test.pdf") }).first else {
                throw Abort(.internalServerError)
            }
            
            return home + "/" + path
        } else {
            throw Abort(.internalServerError, reason: "Update your OS")
        }
    }
    
    func file(for path: String? = nil)throws -> File {
        let path = try path ?? self.getPDF()
        guard let name = path.split(separator: "/").map(String.init).last else {
            throw Abort(.internalServerError, reason: "Invalid File Name")
        }
        guard let data = FileManager.default.contents(atPath: path) else {
            throw Abort(.internalServerError, reason: "No File or Data at path \(path)")
        }
        
        return File(data: data, filename: name)
    }
    
    static var allTests: [(String, (CustomerDisputesTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testListEndpoint", testListEndpoint),
        ("testDetailsEndpoint", testDetailsEndpoint),
        ("testAcceptEndpoint", testAcceptEndpoint),
        ("testSettleEndpoint", testSettleEndpoint),
        ("testAppealEndpoint", testAppealEndpoint),
        ("testEscalateEndpoint", testEscalateEndpoint),
        ("testOfferEndpoint", testOfferEndpoint),
        ("testEvidenceEndpoint", testEvidenceEndpoint),
        ("testUpdateStatusEndpoint", testUpdateStatusEndpoint),
        ("testMessageEndpoint", testMessageEndpoint)
    ]
}
