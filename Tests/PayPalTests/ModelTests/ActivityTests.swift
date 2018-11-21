import XCTest
@testable import PayPal

final class ActivityTests: XCTestCase {
    let activity = Activity(
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
        gross: CurrencyCodeAmount(currency: .usd, value: 19.45),
        net: CurrencyCodeAmount(currency: .usd, value: 19.45),
        partnerFee: nil,
        extensions: nil
    )
    
    func testInit()throws {
        
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        
        let generated = try String(data: encoder.encode(self.activity), encoding: .utf8)!
        let json =
        "{\"status\":\"PENDING\",\"id\":\"94C67654-A41B-4421-B0D0-81E6CD587CDB\",\"time_created\":\"2018-07-12T14:14:56Z\"," +
        "\"activity_type\":\"PAYMENT\",\"gross\":{\"value\":\"19.45\",\"currency_code\":\"USD\"}," +
        "\"counterparty\":{\"email\":\"54north@exmaple.com\",\"name\":\"Jonathan Futher\",\"phone_number\":\"314-159-2653\"}," +
        "\"net\":{\"value\":\"19.45\",\"currency_code\":\"USD\"}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let ext = """
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
        """.data(using: .utf8)!
        
        let decoded = try decoder.decode(Activity.self, from: ext)
        
        XCTAssertEqual(self.activity, decoded)
    }
    
    static var allTests: [(String, (ActivityTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

