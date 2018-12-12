import XCTest
import Failable
@testable import PayPal

final class CustomerServiceMessageTests: XCTestCase {
    func testInit()throws {
        let message = try CustomerService.Message(
            type: .online,
            headline: .init("Extra!"),
            logo: .init("url-placeholder"),
            serviceImage: .init("url"),
            sellerMessage: .init("Titanic sunk...")
        )
        
        XCTAssertEqual(message.type, .online)
        XCTAssertEqual(message.headline.value, "Extra!")
        XCTAssertEqual(message.logo.value, "url-placeholder")
        XCTAssertEqual(message.serviceImage.value, "url")
        XCTAssertEqual(message.sellerMessage.value, "Titanic sunk...")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(CustomerService.Message(
            type: .online, headline: .init(String(repeating: "h", count: 51)), logo: nil, serviceImage: nil, sellerMessage: ""
        ))
        try XCTAssertThrowsError(CustomerService.Message(
            type: .online, headline: nil, logo: .init(String(repeating: "l", count: 256)), serviceImage: nil, sellerMessage: ""
        ))
        try XCTAssertThrowsError(CustomerService.Message(
            type: .online, headline: nil, logo: nil, serviceImage: .init(String(repeating: "s", count: 256)), sellerMessage: ""
        ))
        try XCTAssertThrowsError(CustomerService.Message(
            type: .online, headline: nil, logo: nil, serviceImage: nil, sellerMessage: .init(String(repeating: "s", count: 2_001))
        ))
        var message = try CustomerService.Message(
            type: .online,
            headline: .init("Extra!"),
            logo: .init("url-placeholder"),
            serviceImage: .init("url"),
            sellerMessage: .init("Titanic sunk...")
        )
        
        try XCTAssertThrowsError(message.headline <~ String(repeating: "h", count: 51))
        try XCTAssertThrowsError(message.logo <~ String(repeating: "l", count: 256))
        try XCTAssertThrowsError(message.serviceImage <~ String(repeating: "s", count: 256))
        try XCTAssertThrowsError(message.sellerMessage <~ String(repeating: "s", count: 2_001))
        try message.headline <~ String(repeating: "h", count: 50)
        try message.logo <~ String(repeating: "l", count: 255)
        try message.serviceImage <~ String(repeating: "s", count: 255)
        try message.sellerMessage <~ String(repeating: "s", count: 2_000)
        
        XCTAssertEqual(message.headline.value, String(repeating: "h", count: 50))
        XCTAssertEqual(message.logo.value, String(repeating: "l", count: 255))
        XCTAssertEqual(message.serviceImage.value, String(repeating: "s", count: 255))
        XCTAssertEqual(message.sellerMessage.value, String(repeating: "s", count: 2_000))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let message = try CustomerService.Message(
            type: .online,
            headline: .init("Extra!"),
            logo: .init("url-placeholder"),
            serviceImage: .init("url"),
            sellerMessage: .init("Titanic sunk...")
        )
        let json = try String(data: encoder.encode(message), encoding: .utf8)!
        let generated =
            "{\"seller_message\":\"Titanic sunk...\",\"logo_image_url\":\"url\",\"type\":\"ONLINE\",\"service_image_url\":\"url\",\"headline\":\"Extra!\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "type": "ONLINE",
            "headline": "Extra!",
            "logo_image_url": "url",
            "service_image_url": "url",
            "seller_message": "Titanic sunk..."
        }
        """.data(using: .utf8)!
        
        let message = try CustomerService.Message(
            type: .online,
            headline: .init("Extra!"),
            logo: .init("url-placeholder"),
            serviceImage: .init("url"),
            sellerMessage: .init("Titanic sunk...")
        )
        try XCTAssertEqual(message, decoder.decode(CustomerService.Message.self, from: json))
    }
    
    static var allTests: [(String, (CustomerServiceMessageTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



