import XCTest
@testable import PayPal

public final class CustomerServiceMessageTypeTests: XCTestCase {
    struct CSM: Codable {
        var type: CustomerService.Message.MessageType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(CustomerService.Message.MessageType.online.rawValue, "ONLINE")
        XCTAssertEqual(CustomerService.Message.MessageType.retail.rawValue, "RETAIL")
    }
    
    func testAllCase() {
        XCTAssertEqual(CustomerService.Message.MessageType.allCases.count, 2)
        XCTAssertEqual(CustomerService.Message.MessageType.allCases, [.online, .retail])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let online = try String(data: encoder.encode(CSM(type: .online)), encoding: .utf8)
        let retail = try String(data: encoder.encode(CSM(type: .retail)), encoding: .utf8)
        
        XCTAssertEqual(online, "{\"type\":\"ONLINE\"}")
        XCTAssertEqual(retail, "{\"type\":\"RETAIL\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let online = """
        {
            "type": "ONLINE"
        }
        """.data(using: .utf8)!
        let retail = """
        {
            "type": "RETAIL"
        }
        """
        
        try XCTAssertEqual(decoder.decode(CSM.self, from: online).type, .online)
        try XCTAssertEqual(decoder.decode(CSM.self, from: retail).type, .retail)
    }
    
    static var allTests: [(String, (CustomerServiceMessageTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



