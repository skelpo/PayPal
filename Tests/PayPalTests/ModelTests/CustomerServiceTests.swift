import XCTest
@testable import PayPal

final class CustomerServiceTests: XCTestCase {
    func testInit()throws {
        let service = try CustomerService(email: EmailAddress(email: "address@email.com"), phone: PhoneNumber(country: "1", number: "9963191901"), message: [])
        
        try XCTAssertEqual(service.email, EmailAddress(email: "address@email.com"))
        try XCTAssertEqual(service.phone, PhoneNumber(country: "1", number: "9963191901"))
        XCTAssertEqual(service.message, [])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let service = try CustomerService(email: EmailAddress(email: "address@email.com"), phone: PhoneNumber(country: "1", number: "9963191901"), message: [])
        let json = try String(data: encoder.encode(service), encoding: .utf8)!
        let generated =
        "{\"email\":{\"email_address\":\"address@email.com\"},\"phone\":{\"country_code\":\"1\",\"national_number\":\"9963191901\"},\"message\":[]}"
        
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
            "email": {
                "email_address": "address@email.com"
            },
            "message": [],
            "phone": {
                "country_code": "1",
                "national_number": "9963191901"
            }
        }
        """.data(using: .utf8)!
        
        let service = try CustomerService(email: EmailAddress(email: "address@email.com"), phone: PhoneNumber(country: "1", number: "9963191901"), message: [])
        try XCTAssertEqual(service, decoder.decode(CustomerService.self, from: json))
    }
    
    static var allTests: [(String, (CustomerServiceTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
