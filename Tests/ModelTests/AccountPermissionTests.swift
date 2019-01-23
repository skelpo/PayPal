import XCTest
@testable import PayPal

final class AccountPermissionTests: XCTestCase {
    func testInit()throws {
        let permission = AccountPermission(thirdParty: "FDF4D16C-11C0-4792-A956-6A3A9D8B49C2", permissions: [.directPayment])
        
        XCTAssertEqual(permission.thirdParty, "FDF4D16C-11C0-4792-A956-6A3A9D8B49C2")
        XCTAssertEqual(permission.permissions, [.directPayment])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let permission = AccountPermission(thirdParty: "FDF4D16C-11C0-4792-A956-6A3A9D8B49C2", permissions: [.directPayment])
        let generated = try String(data: encoder.encode(permission), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"permissions\":[\"DIRECT_PAYMENT\"],\"third_party\":\"FDF4D16C-11C0-4792-A956-6A3A9D8B49C2\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "third_party": "FDF4D16C-11C0-4792-A956-6A3A9D8B49C2",
            "permissions": [
                "DIRECT_PAYMENT"
            ]
        }
        """.data(using: .utf8)!
        
        let permission = AccountPermission(thirdParty: "FDF4D16C-11C0-4792-A956-6A3A9D8B49C2", permissions: [.directPayment])
        try XCTAssertEqual(permission, decoder.decode(AccountPermission.self, from: json))
    }
    
    static var allTests: [(String, (AccountPermissionTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

