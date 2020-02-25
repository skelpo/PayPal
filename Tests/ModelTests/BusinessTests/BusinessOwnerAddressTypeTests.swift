import XCTest
@testable import PayPal

public final class BusinessOwnerAddressTypeTests: XCTestCase {
    struct BOA: Codable {
        let type: BusinessOwner.Address.AddressType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(BusinessOwner.Address.AddressType.home.rawValue, "HOME")
        XCTAssertEqual(BusinessOwner.Address.AddressType.work.rawValue, "WORK")
        XCTAssertEqual(BusinessOwner.Address.AddressType.principal.rawValue, "PRINCIPAL_BUSINESS")
        XCTAssertEqual(BusinessOwner.Address.AddressType.office.rawValue, "REGISTERED_OFFICE")
        XCTAssertEqual(BusinessOwner.Address.AddressType.mailing.rawValue, "MAILING_ADDRESS")
    }
    
    func testAllCase() {
        XCTAssertEqual(BusinessOwner.Address.AddressType.allCases.count, 5)
        XCTAssertEqual(BusinessOwner.Address.AddressType.allCases, [.home, .work, .principal, .office, .mailing])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let principal = try String(data: encoder.encode(BOA(type: .principal)), encoding: .utf8)
        let office = try String(data: encoder.encode(BOA(type: .office)), encoding: .utf8)
        
        XCTAssertEqual(principal, "{\"type\":\"PRINCIPAL_BUSINESS\"}")
        XCTAssertEqual(office, "{\"type\":\"REGISTERED_OFFICE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let mailing = """
        {
            "type": "MAILING_ADDRESS"
        }
        """.data(using: .utf8)!
        let home = """
        {
            "type": "HOME"
        }
        """
        
        try XCTAssertEqual(decoder.decode(BOA.self, from: mailing).type, .mailing)
        try XCTAssertEqual(decoder.decode(BOA.self, from: home).type, .home)
    }
    
    public static var allTests: [(String, (BusinessOwnerAddressTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





