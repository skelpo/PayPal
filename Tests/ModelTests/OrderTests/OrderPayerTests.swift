import XCTest
@testable import PayPal

public final class OrderPayerTests: XCTestCase {
    func testInit()throws {
        let payer = Order.Payer(method: .creditCard, funding: [], info: .init(email: nil, birthdate: nil, tax: nil, taxType: nil, country: nil, billing: nil))
        
        XCTAssertEqual(payer.method, .creditCard)
        XCTAssertEqual(payer.funding, [])
        XCTAssertEqual(payer.info, .init(email: nil, birthdate: nil, tax: nil, taxType: nil, country: nil, billing: nil))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let payer = Order.Payer(method: .creditCard, funding: [], info: .init(email: nil, birthdate: nil, tax: nil, taxType: nil, country: nil, billing: nil))
        let generated = try String(data: encoder.encode(payer), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"payment_method\":\"credit_card\",\"funding_instruments\":[],\"payer_info\":{}}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "payer_info": {},
            "funding_instruments": [],
            "status": "VERIFIED",
            "payment_method": "credit_card"
        }
        """.data(using: .utf8)!
        
        let payer = try decoder.decode(Order.Payer.self, from: json)
        XCTAssertEqual(payer.funding, [])
        XCTAssertEqual(payer.status, .verified)
        XCTAssertEqual(payer.method, .creditCard)
        XCTAssertEqual(payer.info, .init(email: nil, birthdate: nil, tax: nil, taxType: nil, country: nil, billing: nil))
    }
    
    static var allTests: [(String, (OrderPayerTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





