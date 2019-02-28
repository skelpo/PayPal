import XCTest
@testable import PayPal

public final class PayPalAPIErrorTests: XCTestCase {
    let error = PayPalAPIError(
        identifier: "INVALID_REQUEST",
        reason: "Validation for request data failed",
        informationLink: "https://developer.paypal.com/docs/api/overview/#validation-errors"
    )
    
    func testInit()throws {
        XCTAssertEqual(error.identifier, "INVALID_REQUEST")
        XCTAssertEqual(error.reason, "Validation for request data failed")
        XCTAssertEqual(error.informationLink, "https://developer.paypal.com/docs/api/overview/#validation-errors")
        XCTAssertEqual(error.documentationLinks, ["https://developer.paypal.com/docs/api/overview/#validation-errors"])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let err = try String(data: encoder.encode(self.error), encoding: .utf8)
        let json = "{\"message\":\"Validation for request data failed\",\"name\":\"INVALID_REQUEST\"" +
                   ",\"information_link\":\"https:\\/\\/developer.paypal.com\\/docs\\/api\\/overview\\/#validation-errors\"}"
        
        XCTAssertEqual(err, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let valid = """
        {
            "message": "Validation for request data failed",
            "name": "INVALID_REQUEST",
            "information_link": "https://developer.paypal.com/docs/api/overview/#validation-errors"
        }
        """.data(using: .utf8)!
        let keyFail = """
        {
            "identifier": "INVALID_REQUEST",
            "reason": "Validation for request data failed",
            "informationLink": "https://developer.paypal.com/docs/api/overview/#validation-errors"
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(PayPalAPIError.self, from: keyFail))
        try XCTAssertEqual(self.error, decoder.decode(PayPalAPIError.self, from: valid))
    }
    
    static var allTests: [(String, (PayPalAPIErrorTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

