import XCTest
@testable import PayPal

final class PaymentListTests: XCTestCase {
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let json = """
        {
            "next_id": "2B3A938C-1CB7-41C2-BC2C-DA8902649CF4",
            "payments": [],
            "count" 15
        }
        """.data(using: .utf8)!
        
        var list = try decoder.decode(PaymentList.self, from: json)
        XCTAssertEqual(list.next, "2B3A938C-1CB7-41C2-BC2C-DA8902649CF4")
        XCTAssertEqual(list.payments, [])
        XCTAssertEqual(list.count, 15)
        
        try XCTAssertThrowsError(list.set(\.count <~ 21))
        try list.set(\.count <~ 20)
        
        XCTAssertEqual(list.count, 20)
    }
    
    static var allTests: [(String, (PaymentListTests) -> ()throws -> ())] = [
        ("testDecoding", testDecoding)
    ]
}



