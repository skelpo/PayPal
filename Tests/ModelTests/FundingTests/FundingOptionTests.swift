import XCTest
@testable import PayPal

public final class FundingOptionTests: XCTestCase {
    struct Funding: Codable {
        let option: FundingOption
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(FundingOption.id.rawValue, "funding_option_id")
        XCTAssertEqual(FundingOption.instruments.rawValue, "funding_instruments")
    }
    
    func testAllCase() {
        XCTAssertEqual(FundingOption.allCases.count, 2)
        XCTAssertEqual(FundingOption.allCases, [.id, .instruments])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let id = try String(data: encoder.encode(Funding(option: .id)), encoding: .utf8)
        let instruments = try String(data: encoder.encode(Funding(option: .instruments)), encoding: .utf8)
        
        XCTAssertEqual(id, "{\"option\":\"funding_option_id\"}")
        XCTAssertEqual(instruments, "{\"option\":\"funding_instruments\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let id = """
        {
            "option": "funding_option_id"
        }
        """.data(using: .utf8)!
        let instruments = """
        {
            "option": "funding_instruments"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Funding.self, from: id).option, .id)
        try XCTAssertEqual(decoder.decode(Funding.self, from: instruments).option, .instruments)
    }
    
    public static var allTests: [(String, (FundingOptionTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





