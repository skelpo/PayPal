import XCTest
@testable import PayPal

public final class DisputeChannelTests: XCTestCase {
    struct Dispute: Codable {
        let channel: CustomerDispute.Channel
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(CustomerDispute.Channel.internal.rawValue, "INTERNAL")
        XCTAssertEqual(CustomerDispute.Channel.external.rawValue, "EXTERNAL")
    }
    
    func testAllCase() {
        XCTAssertEqual(CustomerDispute.Channel.allCases.count, 2)
        XCTAssertEqual(CustomerDispute.Channel.allCases, [.internal, .external])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let `internal` = try String(data: encoder.encode(Dispute(channel: .internal)), encoding: .utf8)
        let external = try String(data: encoder.encode(Dispute(channel: .external)), encoding: .utf8)
        
        XCTAssertEqual(`internal`, "{\"channel\":\"INTERNAL\"}")
        XCTAssertEqual(external, "{\"channel\":\"EXTERNAL\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let `internal` = """
        {
            "channel": "INTERNAL"
        }
        """.data(using: .utf8)!
        let external = """
        {
            "channel": "EXTERNAL"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Dispute.self, from: `internal`).channel, .internal)
        try XCTAssertEqual(decoder.decode(Dispute.self, from: external).channel, .external)
    }
    
    public static var allTests: [(String, (DisputeChannelTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

