import XCTest
@testable import PayPal

final class CustomerServiceMessageTests: XCTestCase {
    func testInit()throws {
        let message = try CustomerService.Message(type: .online, headline: "Extra!", logo: "url-placeholder", serviceImage: "url", sellerMessage: "Titanic sunk...")
        
        XCTAssertEqual(message.type, .online)
        XCTAssertEqual(message.headline, "Extra!")
        XCTAssertEqual(message.logo, "url-placeholder")
        XCTAssertEqual(message.serviceImage, "url")
        XCTAssertEqual(message.sellerMessage, "Titanic sunk...")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(CustomerService.Message(
            type: .online, headline: String(repeating: "h", count: 51), logo: nil, serviceImage: nil, sellerMessage: ""
        ))
        try XCTAssertThrowsError(CustomerService.Message(
            type: .online, headline: nil, logo: String(repeating: "l", count: 256), serviceImage: nil, sellerMessage: ""
        ))
        try XCTAssertThrowsError(CustomerService.Message(
            type: .online, headline: nil, logo: nil, serviceImage: String(repeating: "s", count: 256), sellerMessage: ""
        ))
        try XCTAssertThrowsError(CustomerService.Message(
            type: .online, headline: nil, logo: nil, serviceImage: nil, sellerMessage: String(repeating: "s", count: 2_001)
        ))
        var message = try CustomerService.Message(type: .online, headline: "Extra!", logo: "url", serviceImage: "url", sellerMessage: "Titanic sunk...")
        
        try XCTAssertThrowsError(message.set(\CustomerService.Message.headline <~ String(repeating: "h", count: 51)))
        try XCTAssertThrowsError(message.set(\CustomerService.Message.logo <~ String(repeating: "l", count: 256)))
        try XCTAssertThrowsError(message.set(\CustomerService.Message.serviceImage <~ String(repeating: "s", count: 256)))
        try XCTAssertThrowsError(message.set(\.sellerMessage <~ String(repeating: "s", count: 2_001)))
        try message.set(\CustomerService.Message.headline <~ String(repeating: "h", count: 50))
        try message.set(\CustomerService.Message.logo <~ String(repeating: "l", count: 255))
        try message.set(\CustomerService.Message.serviceImage <~ String(repeating: "s", count: 255))
        try message.set(\.sellerMessage <~ String(repeating: "s", count: 2_000))
        
        XCTAssertEqual(message.headline, String(repeating: "h", count: 50))
        XCTAssertEqual(message.logo, String(repeating: "l", count: 255))
        XCTAssertEqual(message.serviceImage, String(repeating: "s", count: 255))
        XCTAssertEqual(message.sellerMessage, String(repeating: "s", count: 2_000))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let message = try CustomerService.Message(type: .online, headline: "Extra!", logo: "url", serviceImage: "url", sellerMessage: "Titanic sunk...")
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
        
        let message = try CustomerService.Message(type: .online, headline: "Extra!", logo: "url", serviceImage: "url", sellerMessage: "Titanic sunk...")
        try XCTAssertEqual(message, decoder.decode(CustomerService.Message.self, from: json))
    }
    
    static var allTests: [(String, (CustomerServiceMessageTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



