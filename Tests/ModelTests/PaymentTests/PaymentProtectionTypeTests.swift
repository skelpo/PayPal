import XCTest
@testable import PayPal

fileprivate typealias Type = RelatedResource.ProtectionType

public final class PaymentProtectionTypeTests: XCTestCase {
    private struct Protection: Codable {
        let type: Type
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Type.itemNotReceived.rawValue, "ITEM_NOT_RECEIVED_ELIGIBLE")
        XCTAssertEqual(Type.unauthorizedPayment.rawValue, "UNAUTHORIZED_PAYMENT_ELIGIBLE")
        XCTAssertEqual(Type.all.rawValue, "ITEM_NOT_RECEIVED_ELIGIBLE,UNAUTHORIZED_PAYMENT_ELIGIBLE")
    }
    
    func testAllCase() {
        XCTAssertEqual(Type.allCases.count, 3)
        XCTAssertEqual(Type.allCases, [.itemNotReceived, .unauthorizedPayment, .all])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let itemNotReceived = try String(data: encoder.encode(Protection(type: .itemNotReceived)), encoding: .utf8)
        let unauthorizedPayment = try String(data: encoder.encode(Protection(type: .unauthorizedPayment)), encoding: .utf8)
        
        XCTAssertEqual(itemNotReceived, "{\"type\":\"ITEM_NOT_RECEIVED_ELIGIBLE\"}")
        XCTAssertEqual(unauthorizedPayment, "{\"type\":\"UNAUTHORIZED_PAYMENT_ELIGIBLE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let all = """
        {
            "type": "ITEM_NOT_RECEIVED_ELIGIBLE,UNAUTHORIZED_PAYMENT_ELIGIBLE"
        }
        """.data(using: .utf8)!
        let itemNotReceived = """
        {
            "type": "ITEM_NOT_RECEIVED_ELIGIBLE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Protection.self, from: all).type, .all)
        try XCTAssertEqual(decoder.decode(Protection.self, from: itemNotReceived).type, .itemNotReceived)
    }
    
    static var allTests: [(String, (PaymentProtectionTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
