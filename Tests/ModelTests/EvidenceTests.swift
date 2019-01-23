import XCTest
import Failable
@testable import PayPal

final class EvidenceTests: XCTestCase {
    func testInit()throws {
        let evidence = try Evidence(
            type: .proofOfFulfillment,
            info: Evidence.Info(
                tracking: [
                    Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
                ],
                refunds: [
                    "2F214F48-2651-498B-9D06-150BF00E85DA"
                ]
            ),
            documents: [Document(name: "README.md", size: "65kb")],
            notes: .init("I win. Ha!"),
            itemID: "4FB4018C-F925-4FC6-B44B-0174C1B59F17"
        )
        
        XCTAssertEqual(evidence.type, .proofOfFulfillment)
        XCTAssertEqual(evidence.notes.value, "I win. Ha!")
        XCTAssertEqual(evidence.itemID, "4FB4018C-F925-4FC6-B44B-0174C1B59F17")
        XCTAssertEqual(evidence.documents, [Document(name: "README.md", size: "65kb")])
        XCTAssertEqual(evidence.info, Evidence.Info(
            tracking: [
                Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
            ],
            refunds: [
                "2F214F48-2651-498B-9D06-150BF00E85DA"
            ]
        ))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Evidence(type: nil, info: nil, documents: nil, notes: .init(String(repeating: "n", count: 2001)), itemID: nil))
        var evidence = try Evidence(type: nil, info: nil, documents: nil, notes: .init(String(repeating: "n", count: 2000)), itemID: nil)
        
        try XCTAssertThrowsError(evidence.notes <~ String(repeating: "n", count: 2001))
        try evidence.notes <~ "You lose"
        
        XCTAssertEqual(evidence.notes.value, "You lose")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let evidence = try Evidence(
            type: .proofOfFulfillment,
            info: Evidence.Info(
                tracking: [
                    Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
                ],
                refunds: [
                    "2F214F48-2651-498B-9D06-150BF00E85DA"
                ]
            ),
            documents: [Document(name: "README.md", size: "65kb")],
            notes: .init("I win. Ha!"),
            itemID: "4FB4018C-F925-4FC6-B44B-0174C1B59F17"
        )
        let generated = try String(data: encoder.encode(evidence), encoding: .utf8)!
        let json =
        "{\"documents\":[{\"name\":\"README.md\",\"size\":\"65kb\"}],\"evidence_info\":{\"tracking_info\":[{\"carrier_name\":\"USPS\"," +
        "\"tracking_url\":\"https:\\/\\/whoshippedit.com\\/shippment\\/9163524667210796186056\"," +
        "\"tracking_number\":\"9163524667210796186056\"}],\"refund_ids\":[\"2F214F48-2651-498B-9D06-150BF00E85DA\"]},\"notes\":\"I win. Ha!\"," +
        "\"evidence_type\":\"PROOF_OF_FULFILLMENT\",\"item_id\":\"4FB4018C-F925-4FC6-B44B-0174C1B59F17\"}"
        
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
        let json = """
        {
            "evidence_type": "PROOF_OF_FULFILLMENT",
            "item_id": "4FB4018C-F925-4FC6-B44B-0174C1B59F17",
            "notes": "I win. Ha!",
            "documents": [
                {
                    "name": "README.md",
                    "size": "65kb"
                }
            ],
            "evidence_info": {
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
        }
        """.data(using: .utf8)!
        let evidence = try Evidence(
            type: .proofOfFulfillment,
            info: Evidence.Info(
                tracking: [
                    Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
                ],
                refunds: [
                    "2F214F48-2651-498B-9D06-150BF00E85DA"
                ]
            ),
            documents: [Document(name: "README.md", size: "65kb")],
            notes: .init("I win. Ha!"),
            itemID: "4FB4018C-F925-4FC6-B44B-0174C1B59F17"
        )
        
        try XCTAssertEqual(evidence, decoder.decode(Evidence.self, from: json))
    }
    
    static var allTests: [(String, (EvidenceTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




