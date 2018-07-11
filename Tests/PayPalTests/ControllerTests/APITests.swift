import XCTest
import Vapor
@testable import PayPal

final class APITests: XCTestCase {
    
    var app: Application!
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPal.Provider())
        
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
        let response = try app.paypal(.GET, "v1/oauth2/token/userinfo?schema=openid", as: [String: String].self).wait()
        
        XCTAssertEqual(response["user_id"], "https://www.paypal.com/webapps/auth/identity/user/eEp3Op59PkxkjwQsK0LkDnv5d7JHwToZs0OkwVcjAZM")
    }
    
    static var allTests: [(String, (APITests) -> ()throws -> ())] = [
        ("testQueryStringEncoding", testQueryStringEncoding),
        ("testAPIHelper", testAPIHelper)
    ]
}


