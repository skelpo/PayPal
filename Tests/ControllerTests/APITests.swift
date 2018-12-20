import XCTest
import Vapor
@testable import PayPal

final class APITests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
    }
    
    func testQueryStringEncoding() {
        let parameters = QueryParamaters(page: 0, pageSize: 25, sortOrder: .ascending)
        let elements = parameters.encode().split(separator: "&").map(String.init)
        
        XCTAssert(elements.contains("next_page_token=0"), "Paramaters does not contain pair 'page=0'")
        XCTAssert(elements.contains("page_size=25"), "Paramaters does not contain pair 'page_size=25'")
        XCTAssert(elements.contains("sort_order=ascending"), "Paramaters does not contain pair 'sort_order=ascending'")
    }
    
    func testAPIHelper()throws {
        try self.app.make(PayPalClient.self).authenticate().wait()
        
        let info = try self.app.make(AuthInfo.self)
        XCTAssertNotNil(info.token)
    }
    
    static var allTests: [(String, (APITests) -> ()throws -> ())] = [
        ("testQueryStringEncoding", testQueryStringEncoding),
        ("testAPIHelper", testAPIHelper)
    ]
}

