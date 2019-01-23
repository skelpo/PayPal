import XCTest
@testable import PayPal

final class FraudManagementFilterTests: XCTestCase {
    func testDecoding()throws {
        let json = """
        {
            "filter_type": "PENDING",
            "filter_id": "CARD_SECURITY_CODE_MISMATCH",
            "name": "Named",
            "description": "Descripted"
        }
        """.data(using: .utf8)!
        
        let filter = try JSONDecoder().decode(FraudManagementFilter.self, from: json)
        
        XCTAssertEqual(filter.type, .pending)
        XCTAssertEqual(filter.id, .securityCodeMismatch)
        XCTAssertEqual(filter.name, "Named")
        XCTAssertEqual(filter.description, "Descripted")
    }
    
    static var allTests: [(String, (FraudManagementFilterTests) -> ()throws -> ())] = [
        ("testDecoding", testDecoding)
    ]
}
