import XCTest
@testable import PayPal

public final class OrderPaymentRequestTests: XCTestCase {
    func testInit()throws {
        let request = Order.PaymentRequest(disbursement: .instant, payer: Order.Payer(method: nil, funding: nil, info: nil))
        
        XCTAssertEqual(request.disbursement, .instant)
        XCTAssertEqual(request.payer, .init(method: nil, funding: nil, info: nil))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let request = Order.PaymentRequest(disbursement: .instant, payer: Order.Payer(method: nil, funding: nil, info: nil))
        let generated = try String(data: encoder.encode(request), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"payer\":{},\"disbursement_mode\":\"INSTANT\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "payer": {},
            "disbursement_mode": "INSTANT"
        }
        """.data(using: .utf8)!
        
        let request = Order.PaymentRequest(disbursement: .instant, payer: Order.Payer(method: nil, funding: nil, info: nil))
        try XCTAssertEqual(request, decoder.decode(Order.PaymentRequest.self, from: json))
    }
    
    static var allTests: [(String, (OrderPaymentRequestTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






