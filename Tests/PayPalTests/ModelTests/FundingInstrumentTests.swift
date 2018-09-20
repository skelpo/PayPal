import XCTest
@testable import PayPal

final class FundingInstrumentTests: XCTestCase {
    func testInit()throws {
        let instrument = FundingInstrument(token: .init(creditCard: "0F874884-66E4-4D45-9906-C3E9957BC1FF", payer: nil))
        
        XCTAssertEqual(instrument.token, .init(creditCard: "0F874884-66E4-4D45-9906-C3E9957BC1FF", payer: nil))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let instrument = FundingInstrument(token: .init(creditCard: "0F874884-66E4-4D45-9906-C3E9957BC1FF", payer: nil))
        let json = try String(data: encoder.encode(instrument), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"credit_card_token\":{\"credit_card_id\":\"0F874884-66E4-4D45-9906-C3E9957BC1FF\"}}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "credit_card_token": {
                "credit_card_id": "0F874884-66E4-4D45-9906-C3E9957BC1FF"
            }
        }
        """.data(using: .utf8)!
        
        let instrument = FundingInstrument(token: .init(creditCard: "0F874884-66E4-4D45-9906-C3E9957BC1FF", payer: nil))
        try XCTAssertEqual(instrument, decoder.decode(FundingInstrument.self, from: json))
    }
    
    static var allTests: [(String, (FundingInstrumentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



