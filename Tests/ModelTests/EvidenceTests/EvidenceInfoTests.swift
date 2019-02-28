import XCTest
@testable import PayPal

public final class EvidenceInfoTests: XCTestCase {
    func testInit()throws {
        let evidence = Evidence.Info(
            tracking: [
                Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
            ],
            refunds: [
                "2F214F48-2651-498B-9D06-150BF00E85DA"
            ]
        )
        
        XCTAssertEqual(evidence.refunds?.count, 1)
        XCTAssertEqual(evidence.refunds?.first, "2F214F48-2651-498B-9D06-150BF00E85DA")
        XCTAssertEqual(evidence.tracking?.count, 1)
        XCTAssertEqual(
            evidence.tracking?.first,
            Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
        )
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let evidence = Evidence.Info(
            tracking: [
                Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
            ],
            refunds: [
                "2F214F48-2651-498B-9D06-150BF00E85DA"
            ]
        )
        let generated = try String(data: encoder.encode(evidence), encoding: .utf8)!
        let json =
            "{\"tracking_info\":[{\"carrier_name\":\"USPS\",\"tracking_url\":\"https:\\/\\/whoshippedit.com\\/shippment\\/9163524667210796186056\"," +
            "\"tracking_number\":\"9163524667210796186056\"}],\"refund_ids\":[\"2F214F48-2651-498B-9D06-150BF00E85DA\"]}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "tracking_info": [
                {
                    "carrier_name": "USPS",
                    "tracking_url": "https://whoshippedit.com/shippment/9163524667210796186056",
                    "tracking_number": "9163524667210796186056"
                }
            ],
            "refund_ids": [
                "2F214F48-2651-498B-9D06-150BF00E85DA"
            ]
        }
        """.data(using: .utf8)!
        
        let evidence = Evidence.Info(
            tracking: [
                Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
            ],
            refunds: [
                "2F214F48-2651-498B-9D06-150BF00E85DA"
            ]
        )
        try XCTAssertEqual(evidence, decoder.decode(Evidence.Info.self, from: json))
    }
    
    static var allTests: [(String, (EvidenceInfoTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



