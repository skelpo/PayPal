import XCTest
@testable import PayPal

final class InvoiceParticipantTests: XCTestCase {
    func testInit()throws {
        let participant = try Invoice.Participant(email: "participant@example.com")
        
        XCTAssertEqual(participant.email, "participant@example.com")
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Invoice.Participant(email: String(repeating: "e", count: 261)))
        var participant = try Invoice.Participant(email: "participant@example.com")
        
        try XCTAssertThrowsError(participant.set(\.email <~ String(repeating: "e", count: 261)))
        try participant.set(\.email <~ "email@example.com")
        
        XCTAssertEqual(participant.email, "email@example.com")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let participant = try Invoice.Participant(email: "participant@example.com")
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
        
        let participant = try Invoice.Participant(email: "participant@example.com")
        try XCTAssertEqual(participant, decoder.decode(Invoice.Participant.self, from: json))
    }
    
    static var allTests: [(String, (InvoiceParticipantTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



