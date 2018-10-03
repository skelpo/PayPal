import XCTest
@testable import PayPal

@available(OSX 10.12, *)
final class ActivitiesResponseTests: XCTestCase {
    let response = ActivitiesResponse(items: [
            Activity(
                id: "94C67654-A41B-4421-B0D0-81E6CD587CDB",
                timeCreated: "2018-07-12T14:14:56Z",
                type: .payment,
                subtype: nil,
                status: .pending,
                counterparty: CounterParty(
                    email: "54north@exmaple.com",
                    phoneNumber: "314-159-2653",
                    name: "Jonathan Futher"
                ),
                fee: nil,
                gross: try! Money(
                    currency: .usd,
                    value: "19.45"
                ),
                net: try! Money(
                    currency: .usd,
                    value: "19.45"
                ),
                partnerFee: nil,
                extensions: nil
            )
        ],
        links: [
            LinkDescription(href: "https://developer.paypal.com/docs/api/activities/v1/#activities", rel: "external", method: .GET)
        ]
    )
    
    func testInit()throws {
        XCTAssertEqual(response.items, [
            Activity(
                id: "94C67654-A41B-4421-B0D0-81E6CD587CDB",
                timeCreated: "2018-07-12T14:14:56Z",
                type: .payment,
                subtype: nil,
                status: .pending,
                counterparty: CounterParty(
                    email: "54north@exmaple.com",
                    phoneNumber: "314-159-2653",
                    name: "Jonathan Futher"
                ),
                fee: nil,
                gross: try! Money(
                    currency: .usd,
                    value: "19.45"
                ),
                net: try! Money(
                    currency: .usd,
                    value: "19.45"
                ),
                partnerFee: nil,
                extensions: nil
            )
        ])
        XCTAssertEqual(response.links, [
            LinkDescription(href: "https://developer.paypal.com/docs/api/activities/v1/#activities", rel: "external", method: .GET)
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        
        let generated = try String(data: encoder.encode(self.response), encoding: .utf8)!
        let json =
            "{\"items\":[{\"status\":\"PENDING\",\"id\":\"94C67654-A41B-4421-B0D0-81E6CD587CDB\",\"time_created\":\"2018-07-12T14:14:56Z\"," +
            "\"activity_type\":\"PAYMENT\",\"gross\":{\"value\":\"19.45\",\"currency_code\":\"USD\"}," +
            "\"counterparty\":{\"email\":\"54north@exmaple.com\",\"name\":\"Jonathan Futher\",\"phone_number\":\"314-159-2653\"}," +
            "\"net\":{\"value\":\"19.45\",\"currency_code\":\"USD\"}}],\"links\":" +
            "[{\"rel\":\"external\",\"href\":\"https:\\/\\/developer.paypal.com\\/docs\\/api\\/activities\\/v1\\/#activities\",\"method\":\"GET\"}]}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            
            print(generated)
            print()
            print(json)
            print()
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()

        let ext = """
        {
            "items": [
                {
                    "id": "94C67654-A41B-4421-B0D0-81E6CD587CDB",
                    "time_created": "2018-07-12T14:14:56Z",
                    "activity_type": "PAYMENT",
                    "status": "PENDING",
                    "counterparty": {
                        "email": "54north@exmaple.com",
                        "phone_number": "314-159-2653",
                        "name": "Jonathan Futher"
                    },
                    "gross": {
                        "currency_code": "USD",
                        "value": "19.45"
                    },
                    "net": {
                        "currency_code": "USD",
                        "value": "19.45"
                    }
                }
            ],
            "links": [
                {
                    "rel": "external",
                    "href": "https://developer.paypal.com/docs/api/activities/v1/#activities",
                    "method": "GET"
                }
            ]
        }
        """.data(using: .utf8)!

        let decoded = try decoder.decode(ActivitiesResponse.self, from: ext)

        XCTAssertEqual(self.response, decoded)
    }
    
    static var allTests: [(String, (ActivitiesResponseTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
