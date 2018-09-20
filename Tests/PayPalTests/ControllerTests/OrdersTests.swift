import XCTest
import Vapor
@testable import PayPal

final class OrdersTests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
    }
    
    func testServiceExists()throws {
        _ = try app.make(Orders.self)
    }
    
    func testCreateEndpoints()throws {
        let sales = try [
            Sale(amount: DetailedAmount(currency: .usd, total: "150.78", details:
                DetailedAmount.Detail(
                    subtotal: "140.00",
                    shipping: "9.00",
                    tax: "1.78",
                    handlingFee: nil,
                    shippingDiscount: nil,
                    insurance: nil,
                    giftWrap: nil)
                ),
                transaction: Amount(currency: .usd, value: "1.50")
            )
        ]
        
        let order = try Order(
            intent: .sale,
            units: [],
            payment: .init(captures: nil, refunds: nil, sales: sales, authorizations: nil),
            total: Amount(currency: .usd, value: "150.78"),
            context: AppContext(brand: "Example Inc.", locale: "us-AZ", landingPage: nil, shipping: .buyer, userAction: nil, data: nil),
            metadata: nil,
            redirects: .init(return: "https://example.com/approved", cancel: "https://example.com/cancel")
        )
        
        let orders = try self.app.make(Orders.self)
        let created = try orders.create(order: order, partnerID: nil).wait()
        
        XCTAssertNotNil(created.id)
        XCTAssertEqual(created.context?.brand, "Example Inc.")
    }
    
    func testCancelEndpoints()throws {
        let orders = try self.app.make(Orders.self)
        let status = try orders.cancel(order: "").wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testDetailsEndpoint()throws {
        let id = ""
        let orders = try self.app.make(Orders.self)
        let order = try orders.details(for: id).wait()
        
        XCTAssertEqual(order.id, id)
    }
    
    static var allTests: [(String, (OrdersTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoints", testCreateEndpoints),
        ("testCancelEndpoints", testCancelEndpoints),
        ("testDetailsEndpoint", testDetailsEndpoint)
    ]
}

