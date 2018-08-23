import XCTest
@testable import PayPal

final class SalesVenueTests: XCTestCase {
    func testInit()throws {
        let venue = SalesVenue(type: .ebay, ebayID: "D6013453-B76E-4CDD-A021-DFD31A4031FE", description: "Online Ebay Store")
        
        XCTAssertEqual(venue.type, .ebay)
        XCTAssertEqual(venue.ebayID, "D6013453-B76E-4CDD-A021-DFD31A4031FE")
        XCTAssertEqual(venue.description, "Online Ebay Store")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let venue = SalesVenue(type: .ebay, ebayID: "D6013453-B76E-4CDD-A021-DFD31A4031FE", description: "Online Ebay Store")
        let generated = try String(data: encoder.encode(venue), encoding: .utf8)!
        let json = "{\"type\":\"EBAY\",\"ebay_id\":\"D6013453-B76E-4CDD-A021-DFD31A4031FE\",\"description\":\"Online Ebay Store\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let venue = SalesVenue(type: .ebay, ebayID: "D6013453-B76E-4CDD-A021-DFD31A4031FE", description: "Online Ebay Store")
        
        let json = """
        {
            "type": "EBAY",
            "ebay_id": "D6013453-B76E-4CDD-A021-DFD31A4031FE",
            "description": "Online Ebay Store"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(venue, decoder.decode(SalesVenue.self, from: json))
    }
    
    static var allTests: [(String, (SalesVenueTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



