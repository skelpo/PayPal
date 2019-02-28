import XCTest
@testable import PayPal

public final class UpdateActionTests: XCTestCase {
    struct Update: Codable {
        let action: UpdateAction
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(UpdateAction.buyer.rawValue, "BUYER_EVIDENCE")
        XCTAssertEqual(UpdateAction.seller.rawValue, "SELLER_EVIDENCE")
    }
    
    func testAllCase() {
        XCTAssertEqual(UpdateAction.allCases.count, 2)
        XCTAssertEqual(UpdateAction.allCases, [.buyer, .seller])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let buyer = try String(data: encoder.encode(Update(action: .buyer)), encoding: .utf8)
        let seller = try String(data: encoder.encode(Update(action: .seller)), encoding: .utf8)
        
        XCTAssertEqual(buyer, "{\"action\":\"BUYER_EVIDENCE\"}")
        XCTAssertEqual(seller, "{\"action\":\"SELLER_EVIDENCE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let buyer = """
        {
            "action": "BUYER_EVIDENCE"
        }
        """.data(using: .utf8)!
        let seller = """
        {
            "action": "SELLER_EVIDENCE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Update.self, from: buyer).action, .buyer)
        try XCTAssertEqual(decoder.decode(Update.self, from: seller).action, .seller)
    }
    
    static var allTests: [(String, (UpdateActionTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

