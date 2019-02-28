import XCTest
@testable import PayPal

public final class OfferTypeTests: XCTestCase {
    struct Off: Codable {
        let type: Offer.OfferType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Offer.OfferType.refund.rawValue, "REFUND")
        XCTAssertEqual(Offer.OfferType.return.rawValue, "REFUND_WITH_RETURN")
        XCTAssertEqual(Offer.OfferType.replacement.rawValue, "REFUND_WITH_REPLACEMENT")
    }
    
    func testAllCase() {
        XCTAssertEqual(Offer.OfferType.allCases.count, 3)
        XCTAssertEqual(Offer.OfferType.allCases, [.refund, .return, .replacement])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let refund = try String(data: encoder.encode(Off(type: .refund)), encoding: .utf8)
        let `return` = try String(data: encoder.encode(Off(type: .return)), encoding: .utf8)
        
        XCTAssertEqual(refund, "{\"type\":\"REFUND\"}")
        XCTAssertEqual(`return`, "{\"type\":\"REFUND_WITH_RETURN\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let replacement = """
        {
            "type": "REFUND_WITH_REPLACEMENT"
        }
        """.data(using: .utf8)!
        let refund = """
        {
            "type": "REFUND"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Off.self, from: replacement).type, .replacement)
        try XCTAssertEqual(decoder.decode(Off.self, from: refund).type, .refund)
    }
    
    public static var allTests: [(String, (OfferTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



