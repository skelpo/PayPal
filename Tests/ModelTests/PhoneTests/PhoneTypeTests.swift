import XCTest
@testable import PayPal

public final class PhoneTypeTests: XCTestCase {
    struct Phone: Codable {
        let type: PhoneType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(PhoneType.home.rawValue, "HOME")
        XCTAssertEqual(PhoneType.mobile.rawValue, "MOBILE")
        XCTAssertEqual(PhoneType.business.rawValue, "BUSINESS")
        XCTAssertEqual(PhoneType.work.rawValue, "WORK")
        XCTAssertEqual(PhoneType.customerService.rawValue, "CUSTOMER_SERVICE")
        XCTAssertEqual(PhoneType.fax.rawValue, "FAX")
        XCTAssertEqual(PhoneType.other.rawValue, "OTHER")
        XCTAssertEqual(PhoneType.pager.rawValue, "PAGER")
    }
    
    func testAllCase() {
        XCTAssertEqual(PhoneType.allCases.count, 8)
        XCTAssertEqual(PhoneType.allCases, [.home, .mobile, .business, .work, .customerService, .fax, .other, .pager])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let customerService = try String(data: encoder.encode(Phone(type: .customerService)), encoding: .utf8)
        let business = try String(data: encoder.encode(Phone(type: .business)), encoding: .utf8)
        
        XCTAssertEqual(customerService, "{\"type\":\"CUSTOMER_SERVICE\"}")
        XCTAssertEqual(business, "{\"type\":\"BUSINESS\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let pager = """
        {
            "type": "PAGER"
        }
        """.data(using: .utf8)!
        let work = """
        {
            "type": "WORK"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Phone.self, from: pager).type, .pager)
        try XCTAssertEqual(decoder.decode(Phone.self, from: work).type, .work)
    }
    
    public static var allTests: [(String, (PhoneTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



