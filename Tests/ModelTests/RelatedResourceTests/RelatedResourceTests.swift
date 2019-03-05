import XCTest
@testable import PayPal

public final class RelatedResourceTests: XCTestCase {
    func testInit()throws {
        let now = Date()
        let resource = RelatedResource(
            sale: .init(id: "", amount: DetailedAmount(currency: .usd, total: 10.0, details: nil), state: .pending, parent: "10", created: now),
            authorization: .init(amount: DetailedAmount(currency: .usd, total: 10, details: nil), fmf: nil, processor: nil),
            order: .init(amount: DetailedAmount(currency: .usd, total: 10, details: nil), fmf: nil),
            capture: .init(amount: nil, isFinal: nil, invoice: nil, transaction: nil, payerNote: nil),
            refund: .init(amount: nil, reason: nil, invoice: nil, description: nil)
        )
        
        XCTAssertEqual(resource.refund, .init(amount: nil, reason: nil, invoice: nil, description: nil))
        XCTAssertEqual(resource.order, .init(amount: DetailedAmount(currency: .usd, total: 10, details: nil), fmf: nil))
        XCTAssertEqual(resource.capture, .init(amount: nil, isFinal: nil, invoice: nil, transaction: nil, payerNote: nil))
        XCTAssertEqual(resource.authorization, .init(amount: DetailedAmount(currency: .usd, total: 10, details: nil), fmf: nil, processor: nil))
        XCTAssertEqual(
            resource.sale,
            .init(id: "", amount: DetailedAmount(currency: .usd, total: 10, details: nil), state: .pending, parent: "10", created: now)
        )
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let date = Date()
        let resource = RelatedResource(
            sale: .init(id: "", amount: DetailedAmount(currency: .usd, total: 10, details: nil), state: .pending, parent: "10", created: date),
            authorization: .init(amount: DetailedAmount(currency: .usd, total: 10, details: nil), fmf: nil, processor: nil),
            order: .init(amount: DetailedAmount(currency: .usd, total: 10, details: nil), fmf: nil),
            capture: .init(amount: nil, isFinal: nil, invoice: nil, transaction: nil, payerNote: nil),
            refund: .init(amount: nil, reason: nil, invoice: nil, description: nil)
        )
        let generated = try String(data: encoder.encode(resource), encoding: .utf8)!
        
        let json =
            "{\"refund\":{},\"order\":{\"amount\":{\"currency\":\"USD\",\"total\":\"10.00\"}}," +
            "\"sale\":{\"amount\":{\"currency\":\"USD\",\"total\":\"10.00\"},\"id\":\"\",\"state\":\"pending\",\"create_time\":\"\(date.iso8601)\"," +
            "\"parent_payment\":\"10\"},\"authorization\":{\"amount\":{\"currency\":\"USD\",\"total\":\"10.00\"}},\"capture\":{}}"
        
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let date = Date()
        let decoder = JSONDecoder()
        let json = """
        {
            "sale": {
                "id": "",
                "amount": {
                    "currency": "USD",
                    "total": "10"
                },
                "state": "pending",
                "parent_payment": "10",
                "create_time": "\(date.iso8601)"
            },
            "authorization": {
                "amount": {
                    "currency": "USD",
                    "total": "10"
                }
            },
            "order": {
                "amount": {
                    "currency": "USD",
                    "total": "10"
                }
            },
            "capture": {},
            "refund": {}
        }
        """.data(using: .utf8)!
        
        let resource = RelatedResource(
            sale: .init(id: "", amount: DetailedAmount(currency: .usd, total: 10, details: nil), state: .pending, parent: "10", created: date),
            authorization: .init(amount: DetailedAmount(currency: .usd, total: 10, details: nil), fmf: nil, processor: nil),
            order: .init(amount: DetailedAmount(currency: .usd, total: 10, details: nil), fmf: nil),
            capture: .init(amount: nil, isFinal: nil, invoice: nil, transaction: nil, payerNote: nil),
            refund: .init(amount: nil, reason: nil, invoice: nil, description: nil)
        )
        try XCTAssertEqual(resource, decoder.decode(RelatedResource.self, from: json))
    }
    
    public static var allTests: [(String, (RelatedResourceTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




