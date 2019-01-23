import XCTest
@testable import PayPal

final class PayPalAPIIdentityErrorTests: XCTestCase {
    let error = PayPalAPIIdentityError(identifier: "invalid_client", reason: "Client Authentication failed")
    
    func testInit()throws {
        XCTAssertEqual(error.identifier, "invalid_client")
        XCTAssertEqual(error.reason, "Client Authentication failed")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let err = try String(data: encoder.encode(self.error), encoding: .utf8)
        let json = "{\"error_description\":\"Client Authentication failed\",\"error\":\"invalid_client\"}"
        
        XCTAssertEqual(err, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let valid = """
        {
            "error_description": "Client Authentication failed",
            "error": "invalid_client"
        }
        """.data(using: .utf8)!
        let keyFail = """
        {
            "reason": "Client Authentication failed",
            "identifier": "invalid_client"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(PayPalAPIIdentityError.self, from: keyFail))
        try XCTAssertEqual(self.error, decoder.decode(PayPalAPIIdentityError.self, from: valid))
    }
    
    static var allTests: [(String, (PayPalAPIIdentityErrorTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


