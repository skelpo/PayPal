import XCTest
import Failable
@testable import PayPal

public final class InvoiceParticipantTests: XCTestCase {
    func testInit()throws {
        let participant = try Invoice.Participant(email: .init("participant@example.com"))
        
        XCTAssertEqual(participant.email.value, "participant@example.com")
    }
    
    func testValidations()throws {
        var participant = Invoice.Participant(email: "participant@example.com")
        
        try XCTAssertThrowsError(participant.email <~ String(repeating: "e", count: 261))
        try participant.email <~ "email@example.com"
        
        XCTAssertEqual(participant.email.value, "email@example.com")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let participant = try Invoice.Participant(email: .init("participant@example.com"))
        let generated = try String(data: encoder.encode(participant), encoding: .utf8)
        let json = "{\"email\":\"participant@example.com\"}"
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "email": "participant@example.com"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(Invoice.Participant(email: .init("participant@example.com")), decoder.decode(Invoice.Participant.self, from: json))
    }
    
    public static var allTests: [(String, (InvoiceParticipantTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



