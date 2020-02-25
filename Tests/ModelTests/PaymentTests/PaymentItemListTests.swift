import XCTest
import Failable
@testable import PayPal

public final class PaymentItemListTests: XCTestCase {
    let address = Address(
        recipientName: nil,
        defaultAddress: nil,
        line1: "line",
        line2: nil,
        city: "city",
        state: nil,
        country: .unitedStates,
        postalCode: "1",
        phone: nil,
        type: nil
    )
    
    func testInit()throws {
        let list = try Payment.ItemList(items: [], address: self.address, phoneNumber: .init("555-555-5555"))
        
        XCTAssertEqual(list.items, [])
        XCTAssertEqual(list.phoneNumber.value, "555-555-5555")
        XCTAssertEqual(list.address, Address(
            recipientName: nil,
            defaultAddress: nil,
            line1: "line",
            line2: nil,
            city: "city",
            state: nil,
            country: .unitedStates,
            postalCode: "1",
            phone: nil,
            type: nil
        ))
    }
    
    func testValidations()throws {
        var list = try Payment.ItemList(items: [], address: self.address, phoneNumber: .init("555-555-5555"))
        
        try XCTAssertThrowsError(list.phoneNumber <~ "")
        try XCTAssertThrowsError(list.phoneNumber <~ "555555555555555555555555555555555555555555555555555")
        try list.phoneNumber <~ "666-666-6666"
        
        XCTAssertEqual(list.phoneNumber.value, "666-666-6666")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let list = try Payment.ItemList(items: [], address: self.address, phoneNumber: .init("555-555-5555"))
        let generated = try String(data: encoder.encode(list), encoding: .utf8)!
        let json =
            "{\"items\":[],\"shipping_address\":{\"country_code\":\"US\",\"line1\":\"line\",\"city\":\"city\",\"postal_code\":\"1\"}," +
            "\"shipping_phone_number\":\"555-555-5555\"}"
        
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
            "items": [],
            "shipping_address": {
                "line1": "line",
                "city": "city",
                "country_code": "US",
                "postal_code": "1"
            },
            "shipping_phone_number": "555-555-5555"
        }
        """.data(using: .utf8)!
        let phone = """
        {
            "shipping_phone_number": "555555555555555555555555555555555555555555555555555"
        }
        """.data(using: .utf8)!
        
        let list = try Payment.ItemList(items: [], address: self.address, phoneNumber: .init("555-555-5555"))
        try XCTAssertEqual(list, decoder.decode(Payment.ItemList.self, from: json))
        try XCTAssertThrowsError(decoder.decode(Payment.ItemList.self, from: phone))
    }
    
    public static var allTests: [(String, (PaymentItemListTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






