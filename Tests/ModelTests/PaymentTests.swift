import XCTest
import Failable
@testable import PayPal

final class PaymentTests: XCTestCase {
    func testInit()throws {
        let payment = try Payment(
            intent: .order,
            payer: .init(method: nil, funding: nil, info: nil),
            context: .init(),
            transactions: [],
            experience: "exp",
            payerNote: .init("note"),
            redirects: .init(return: nil, cancel: nil)
        )
        
        XCTAssertNil(payment.id)
        XCTAssertNil(payment.state)
        XCTAssertNil(payment.failure)
        XCTAssertNil(payment.created)
        XCTAssertNil(payment.updated)
        XCTAssertNil(payment.links)
        XCTAssertEqual(payment.intent, .order)
        XCTAssertEqual(payment.payer, .init(method: nil, funding: nil, info: nil))
        XCTAssertEqual(payment.transactions, [])
        XCTAssertEqual(payment.experience, "exp")
        XCTAssertEqual(payment.payerNote.value, "note")
        XCTAssertEqual(payment.redirects, .init(return: nil, cancel: nil))
        XCTAssertEqual(payment.context, .init())
    }
    
    func testValidations()throws {
        var payment = try Payment(intent: nil, payer: nil, context: nil, transactions: nil, experience: nil, payerNote: .init("note"), redirects: nil)
        
        try XCTAssertThrowsError(payment.payerNote <~ String(repeating: "p", count: 166))
        try payment.payerNote <~ String(repeating: "p", count: 165)
        
        XCTAssertEqual(payment.payerNote.value, String(repeating: "p", count: 165))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let payment = try Payment(
            intent: .order,
            payer: .init(method: nil, funding: nil, info: nil),
            context: .init(),
            transactions: [],
            experience: "exp",
            payerNote: .init("note"),
            redirects: .init(return: nil, cancel: nil)
        )
        let generated = try String(data: encoder.encode(payment), encoding: .utf8)!
        let json =
            "{\"intent\":\"order\",\"redirect_urls\":{},\"experience_profile_id\":\"exp\",\"transactions\":[],\"payer\":{}," +
            "\"application_context\":{},\"note_to_payer\":\"note\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let created = (Date() - (60 * 60 * 24 * 7)).iso8601
        let updated = (Date() - (60 * 60 * 24 * 3)).iso8601
        let decoder = JSONDecoder()
        
        let json = """
        {
            "id": "0F08F1F7-28CC-41AB-A451-5A5398B27F6F",
            "state": "failed",
            "failure_reason": "REDIRECT_REQUIRED",
            "create_time": "\(created)",
            "update_time": "\(updated)",
            "links": [],
            "redirect_urls": {},
            "note_to_payer": "note",
            "experience_profile_id": "exp",
            "transactions": [],
            "application_context": {},
            "payer": {},
            "intent": "order"
        }
        """.data(using: .utf8)!
        let note = """
        {
            "note_to_payer": "\(String(repeating: "n", count: 166))"
        }
        """.data(using: .utf8)!
        
        let payment = try decoder.decode(Payment.self, from: json)
        
        XCTAssertEqual(payment.id, "0F08F1F7-28CC-41AB-A451-5A5398B27F6F")
        XCTAssertEqual(payment.state, .failed)
        XCTAssertEqual(payment.failure, .redirect)
        XCTAssertEqual(payment.created, created)
        XCTAssertEqual(payment.updated, updated)
        XCTAssertEqual(payment.links, [])
        XCTAssertEqual(payment.intent, .order)
        XCTAssertEqual(payment.payer, .init(method: nil, funding: nil, info: nil))
        XCTAssertEqual(payment.transactions, [])
        XCTAssertEqual(payment.experience, "exp")
        XCTAssertEqual(payment.payerNote.value, "note")
        XCTAssertEqual(payment.redirects, .init(return: nil, cancel: nil))
        XCTAssertEqual(payment.context, .init())
        
        try XCTAssertThrowsError(decoder.decode(Payment.self, from: note))
    }
    
    static var allTests: [(String, (PaymentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




