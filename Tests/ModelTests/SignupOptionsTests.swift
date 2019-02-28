import XCTest
@testable import PayPal

public final class SignupOptionsTests: XCTestCase {
    let web = WebExperiencePreference(
        partnerLogo: nil,
        returnURL: nil,
        returnDescription: nil,
        actionRenewal: nil,
        showAddCC: nil,
        mobileConfirmation: nil,
        miniBrowser: nil,
        emailConfirmation: nil
    )
    
    func testInit()throws {
        let options = SignupOptions(partner: [:], legal: [], web: web, notification: NotificationOptions())
        
        XCTAssertEqual(options.partner, PartnerOptions(fields: []))
        XCTAssertEqual(options.legal, [])
        XCTAssertEqual(options.web, web)
        XCTAssertEqual(options.notification, NotificationOptions())
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let options = SignupOptions(partner: PartnerOptions(fields: nil), legal: [], web: web, notification: NotificationOptions())
        
        let generated = try String(data: encoder.encode(options), encoding: .utf8)!
        let json = "{\"notification_options\":{},\"web_experience_preference\":{},\"legal_agreements\":[],\"partner_options\":{}}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "partner_options": {},
            "legal_agreements": [],
            "web_experience_preference": {},
            "notification_options": {}
        }
        """.data(using: .utf8)!
        
        let options = SignupOptions(partner: PartnerOptions(fields: nil), legal: [], web: web, notification: NotificationOptions())
        
        try XCTAssertEqual(options, decoder.decode(SignupOptions.self, from: json))
    }
    
    static var allTests: [(String, (SignupOptionsTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


