import XCTest
import Failable
@testable import PayPal

public final class MerchantInfoTests: XCTestCase {
    func testInit()throws {
        let info = try MerchantInfo(
            email: .init("merchant@exmaple.com"),
            business: .init("Merchants & Co."),
            firstName: .init("Richard"),
            lastName: .init("Smith"),
            address: nil,
            phone: nil,
            fax: nil,
            website: .init("https://merchantsand.co"),
            taxID: .init("9987-425-1698"),
            info: .init("Open 24/7")
        )
        
        XCTAssertNil(info.address)
        XCTAssertNil(info.phone)
        XCTAssertNil(info.fax)
        XCTAssertEqual(info.email.value, "merchant@exmaple.com")
        XCTAssertEqual(info.business.value, "Merchants & Co.")
        XCTAssertEqual(info.firstName.value, "Richard")
        XCTAssertEqual(info.lastName.value, "Smith")
        XCTAssertEqual(info.website.value, "https://merchantsand.co")
        XCTAssertEqual(info.taxID.value, "9987-425-1698")
        XCTAssertEqual(info.info.value, "Open 24/7")
    }
    
    func testValidations()throws {
        var info = try MerchantInfo(
            email: nil, business: nil, firstName: nil, lastName: nil, address: nil, phone: nil, fax: nil, website: nil,
            taxID: nil, info: nil
        )
        
        try XCTAssertThrowsError(info.email <~ String(repeating: "e", count: 261))
        try XCTAssertThrowsError(info.business <~ String(repeating: "b", count: 101))
        try XCTAssertThrowsError(info.firstName <~ String(repeating: "f", count: 257))
        try XCTAssertThrowsError(info.lastName <~ String(repeating: "l", count: 257))
        try XCTAssertThrowsError(info.website <~ String(repeating: "w", count: 2049))
        try XCTAssertThrowsError(info.taxID <~ String(repeating: "t", count: 101))
        try XCTAssertThrowsError(info.info <~ String(repeating: "i", count: 41))
        
        try info.email <~ String(repeating: "e", count: 260)
        try info.business <~ String(repeating: "b", count: 100)
        try info.firstName <~ String(repeating: "f", count: 256)
        try info.lastName <~ String(repeating: "l", count: 256)
        try info.website <~ String(repeating: "w", count: 2048)
        try info.taxID <~ String(repeating: "t", count: 100)
        try info.info <~ String(repeating: "i", count: 40)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let info = try MerchantInfo(
            email: .init("merchant@exmaple.com"),
            business: .init("Merchants & Co."),
            firstName: .init("Richard"),
            lastName: .init("Smith"),
            address: nil,
            phone: nil,
            fax: nil,
            website: .init("https://merchantsand.co"),
            taxID: .init("9987-425-1698"),
            info: .init("Open 24/7")
        )
        let generated = try String(data: encoder.encode(info), encoding: .utf8)!
        let json =
            "{\"tax_id\":\"9987-425-1698\",\"website\":\"https:\\/\\/merchantsand.co\",\"business_name\":\"Merchants & Co.\"," +
            "\"last_name\":\"Smith\",\"email\":\"merchant@exmaple.com\",\"additional_info\":\"Open 24\\/7\",\"first_name\":\"Richard\"}"
        
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
            "email": "merchant@exmaple.com",
            "business_name": "Merchants & Co.",
            "first_name": "Richard",
            "last_name": "Smith",
            "website": "https://merchantsand.co",
            "tax_id": "9987-425-1698",
            "additional_info": "Open 24/7"
        }
        """.data(using: .utf8)!
        let info = try MerchantInfo(
            email: .init("merchant@exmaple.com"),
            business: .init("Merchants & Co."),
            firstName: .init("Richard"),
            lastName: .init("Smith"),
            address: nil,
            phone: nil,
            fax: nil,
            website: .init("https://merchantsand.co"),
            taxID: .init("9987-425-1698"),
            info: .init("Open 24/7")
        )
        
        try XCTAssertEqual(info, decoder.decode(MerchantInfo.self, from: json))
    }
    
    public static var allTests: [(String, (MerchantInfoTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}





