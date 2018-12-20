import XCTest
import Failable
@testable import PayPal

final class RelatedResourceRefundTests: XCTestCase {
    func testInit()throws {
        let refund = try RelatedResource.Refund(
            amount: DetailedAmount(currency: .usd, total: 67.23, details: nil),
            reason: "Reasonable",
            invoice: .init("3086FF5B-13F2-4B6A-AB02-AD1C347B163C"),
            description: "Descript"
        )
        
        XCTAssertNil(refund.id)
        XCTAssertNil(refund.state)
        XCTAssertNil(refund.sale)
        XCTAssertNil(refund.capture)
        XCTAssertNil(refund.payment)
        XCTAssertNil(refund.created)
        XCTAssertNil(refund.updated)
        XCTAssertNil(refund.links)
        
        XCTAssertEqual(refund.reason, "Reasonable")
        XCTAssertEqual(refund.invoice.value, "3086FF5B-13F2-4B6A-AB02-AD1C347B163C")
        XCTAssertEqual(refund.description, "Descript")
        XCTAssertEqual(refund.amount, DetailedAmount(currency: .usd, total: 67.23, details: nil))
    }
    
    func testValidations()throws {
        var refund = try RelatedResource.Refund(
            amount: DetailedAmount(currency: .usd, total: 67.23, details: nil),
            reason: "Reasonable",
            invoice: .init("3086FF5B-13F2-4B6A-AB02-AD1C347B163C"),
            description: "Descript"
        )
        
        try XCTAssertThrowsError(refund.invoice <~ String(repeating: "i", count: 128))
        try refund.invoice <~ String(repeating: "i", count: 127)
        
        XCTAssertEqual(refund.invoice.value, String(repeating: "i", count: 127))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let refund = try RelatedResource.Refund(
            amount: DetailedAmount(currency: .usd, total: 67.23, details: nil),
            reason: "Reasonable",
            invoice: .init("3086FF5B-13F2-4B6A-AB02-AD1C347B163C"),
            description: "Descript"
        )
        let generated = try String(data: encoder.encode(refund), encoding: .utf8)!
        
        let json =
            "{\"amount\":{\"currency\":\"USD\",\"total\":\"67.23\"},\"reason\":\"Reasonable\",\"description\":\"Descript\"," +
            "\"invoice_number\":\"3086FF5B-13F2-4B6A-AB02-AD1C347B163C\"}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(json, generated)
    }
    
    func testDecoding()throws {
        let created = Date()
        let updated = Date() + (60 * 60 * 24 * 3)
        
        let decoder = JSONDecoder()
        let json = """
        {
            "id": "7CC72DB1-079B-41C1-8380-06FC4B4A3CFD",
            "amount": {
                "currency": "USD",
                "total": "67.23"
            },
            "state": "pending",
            "reason": "Reasonable",
            "invoice_number": "3086FF5B-13F2-4B6A-AB02-AD1C347B163C",
            "sale_id": "43E42A83-0C79-4254-BC46-8830EB49B760",
            "capture_id": "4AA80819-0094-4B2C-A04D-0CBD3E1FCA74",
            "parent_payment": "FDA5BF1B-D68D-4DB8-93E5-0EA6910DA0A7",
            "description": "Descript",
            "create_time": "\(created.iso8601)",
            "update_time": "\(updated.iso8601)",
            "links": []
        }
        """.data(using: .utf8)!
        let invoice = """
        }
            "invoice_number": "\(String(repeating: "i", count: 128))"
        }
        """.data(using: .utf8)!

        try XCTAssertThrowsError(decoder.decode(RelatedResource.Refund.self, from: invoice))
        
        let refund = try decoder.decode(RelatedResource.Refund.self, from: json)
        XCTAssertEqual(refund.id, "7CC72DB1-079B-41C1-8380-06FC4B4A3CFD")
        XCTAssertEqual(refund.state, .pending)
        XCTAssertEqual(refund.reason, "Reasonable")
        XCTAssertEqual(refund.invoice.value, "3086FF5B-13F2-4B6A-AB02-AD1C347B163C")
        XCTAssertEqual(refund.sale, "43E42A83-0C79-4254-BC46-8830EB49B760")
        XCTAssertEqual(refund.capture, "4AA80819-0094-4B2C-A04D-0CBD3E1FCA74")
        XCTAssertEqual(refund.payment, "FDA5BF1B-D68D-4DB8-93E5-0EA6910DA0A7")
        XCTAssertEqual(refund.description, "Descript")
        XCTAssertEqual(refund.created, created.iso8601)
        XCTAssertEqual(refund.updated, updated.iso8601)
        XCTAssertEqual(refund.links, [])
        XCTAssertEqual(refund.amount, DetailedAmount(currency: .usd, total: 67.23, details: nil))
        
    }
    
    static var allTests: [(String, (RelatedResourceRefundTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






