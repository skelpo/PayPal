import XCTest
import Failable
@testable import PayPal

final class ShippingInfoTests: XCTestCase {
    func testInit()throws {
        let info = try ShippingInfo(
            firstName: .init("Oskar"),
            lastName: .init("Reteep"),
            businessName: .init("Books and Crannies"),
            address: Address(
                recipientName: "Oskar Reteep",
                defaultAddress: true,
                line1: "1 Main Street",
                line2: nil,
                city: "Glipwood",
                state: nil,
                country: .switzerland,
                postalCode: "562",
                phone: nil,
                type: nil
            )
        )
        
        XCTAssertEqual(info.firstName.value, "Oskar")
        XCTAssertEqual(info.lastName.value, "Reteep")
        XCTAssertEqual(info.businessName.value, "Books and Crannies")
        XCTAssertEqual(info.address, Address(
            recipientName: "Oskar Reteep",
            defaultAddress: true,
            line1: "1 Main Street",
            line2: nil,
            city: "Glipwood",
            state: nil,
            country: .switzerland,
            postalCode: "562",
            phone: nil,
            type: nil
        ))
    }
    
    func testValidations()throws {
        var info = try ShippingInfo(
            firstName: .init("Oskar"),
            lastName: .init("Reteep"),
            businessName: .init("Books and Crannies"),
            address: nil
        )
        
        try XCTAssertThrowsError(info.firstName <~ String(repeating: "f", count: 257))
        try XCTAssertThrowsError(info.lastName <~ String(repeating: "l", count: 257))
        try XCTAssertThrowsError(info.businessName <~ String(repeating: "b", count: 481))
        try info.firstName <~ String(repeating: "f", count: 256)
        try info.lastName <~ String(repeating: "l", count: 256)
        try info.businessName <~ String(repeating: "b", count: 480)
        
        XCTAssertEqual(info.firstName.value, String(repeating: "f", count: 256))
        XCTAssertEqual(info.lastName.value, String(repeating: "l", count: 256))
        XCTAssertEqual(info.businessName.value, String(repeating: "b", count: 480))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let info = try ShippingInfo(
            firstName: .init("Oskar"),
            lastName: .init("Reteep"),
            businessName: .init("Books and Crannies"),
            address: nil
        )
        
        let generated = try String(data: encoder.encode(info), encoding: .utf8)!
        let json = "{\"business_name\":\"Books and Crannies\",\"first_name\":\"Oskar\",\"last_name\":\"Reteep\"}"
        
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
            "business_name": "Books and Crannies",
            "last_name": "Reteep",
            "first_name": "Oskar"
        }
        """.data(using: .utf8)!
        let info = try ShippingInfo(
            firstName: .init("Oskar"),
            lastName: .init("Reteep"),
            businessName: .init("Books and Crannies"),
            address: nil
        )
        
        try XCTAssertEqual(info, decoder.decode(ShippingInfo.self, from: json))
    }
    
    static var allTests: [(String, (ShippingInfoTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

