import XCTest
@testable import PayPal

final class VenueTests: XCTestCase {
    struct User: Codable {
        let role: Role
    }
    
    struct Prod: Codable {
        let venue: Venue
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Venue.ebay.rawValue, "EBAY")
        XCTAssertEqual(Venue.market.rawValue, "ANOTHER_MARKET_PLACE")
        XCTAssertEqual(Venue.website.rawValue, "OWN_WEB_SITE")
        XCTAssertEqual(Venue.other.rawValue, "OTHER")
    }
    
    func testAllCase() {
        XCTAssertEqual(Venue.allCases.count, 4)
        XCTAssertEqual(Venue.allCases, [.ebay, .market, .website, .other])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let ebay = try String(data: encoder.encode(Prod(venue: .ebay)), encoding: .utf8)
        let market = try String(data: encoder.encode(Prod(venue: .market)), encoding: .utf8)
        
        XCTAssertEqual(ebay, "{\"venue\":\"EBAY\"}")
        XCTAssertEqual(market, "{\"venue\":\"ANOTHER_MARKET_PLACE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let website = """
        {
            "venue": "OWN_WEB_SITE"
        }
        """.data(using: .utf8)!
        let other = """
        {
            "venue": "OTHER"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Prod.self, from: website).venue, .website)
        try XCTAssertEqual(decoder.decode(Prod.self, from: other).venue, .other)
    }
    
    static var allTests: [(String, (VenueTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



