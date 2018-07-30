import XCTest
@testable import PayPal

final class TrackingTests: XCTestCase {
    func testInit()throws {
        let tracking = Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
        
        XCTAssertNil(tracking.carrierOther)
        XCTAssertEqual(tracking.carrier, .usps)
        XCTAssertEqual(tracking.url, "https://whoshippedit.com/shippment/9163524667210796186056")
        XCTAssertEqual(tracking.number, "9163524667210796186056")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let tracking = Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
        let generated = try String(data: encoder.encode(tracking), encoding: .utf8)!
        let json =
            "{\"tracking_number\":\"9163524667210796186056\",\"tracking_url\":\"https://whoshippedit.com/shippment/9163524667210796186056\"," +
            "\"carrier_name\":\"USPS\"}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "carrier_name": "USPS",
            "tracking_url": "https://whoshippedit.com/shippment/9163524667210796186056",
            "tracking_number": "9163524667210796186056"
        }
        """.data(using: .utf8)!
       
        let tracking = Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
        try XCTAssertEqual(tracking, decoder.decode(Tracking.self, from: json))
    }
    
    static var allTests: [(String, (TrackingTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


