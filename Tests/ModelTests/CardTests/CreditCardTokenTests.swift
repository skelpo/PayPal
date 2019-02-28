import XCTest
@testable import PayPal

public final class CreditCardTokenTests: XCTestCase {
    func testInit()throws {
        let token = CreditCard.Token(creditCard: "94935F7A-395B-4CAF-AC29-DD6728C55FE6", payer: "93A20FF4-D73D-4F76-B591-932D4B6CA3E1")
        
        XCTAssertNil(token.suffix)
        XCTAssertNil(token.type)
        XCTAssertNil(token.expireMonth)
        XCTAssertNil(token.expireYear)
        XCTAssertEqual(token.creditCard, "94935F7A-395B-4CAF-AC29-DD6728C55FE6")
        XCTAssertEqual(token.payer, "93A20FF4-D73D-4F76-B591-932D4B6CA3E1")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let token = CreditCard.Token(creditCard: "94935F7A-395B-4CAF-AC29-DD6728C55FE6", payer: "93A20FF4-D73D-4F76-B591-932D4B6CA3E1")
        let generated = try String(data: encoder.encode(token), encoding: .utf8)!
        let json = "{\"payer_id\":\"93A20FF4-D73D-4F76-B591-932D4B6CA3E1\",\"credit_card_id\":\"94935F7A-395B-4CAF-AC29-DD6728C55FE6\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "credit_card_id": "94935F7A-395B-4CAF-AC29-DD6728C55FE6",
            "payer_id": "93A20FF4-D73D-4F76-B591-932D4B6CA3E1",
            "last4": "1856",
            "type": "visa",
            "expire_month": 5,
            "expire_year": 2022
        }
        """.data(using: .utf8)!
        
        let token = try decoder.decode(CreditCard.Token.self, from: json)
        XCTAssertEqual(token.creditCard, "94935F7A-395B-4CAF-AC29-DD6728C55FE6")
        XCTAssertEqual(token.payer, "93A20FF4-D73D-4F76-B591-932D4B6CA3E1")
        XCTAssertEqual(token.suffix, "1856")
        XCTAssertEqual(token.type, "visa")
        XCTAssertEqual(token.expireMonth, 5)
        XCTAssertEqual(token.expireYear, 2022)
    }
    
    public static var allTests: [(String, (CreditCardTokenTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


