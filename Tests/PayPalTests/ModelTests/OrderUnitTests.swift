import XCTest
@testable import PayPal

final class OrderUnitTests: XCTestCase {
    func testInit()throws {
        let payee = Payee(email: "payee@example.com", merchant: "AEDCA9E0-5442-41EF-978A-DEE6DF7DFDA8", metadata: nil)
        let address = Address(
            recipientName: nil,
            defaultAddress: nil,
            line1: "1 Infinate Loop",
            line2: nil,
            city: "Cupertino",
            state: .ca,
            country: .unitedStates,
            postalCode: "94024",
            phone: nil,
            type: nil
        )
        let unit = try Order.Unit(
            reference: "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A",
            amount: DetailedAmount(currency: .usd, total: 5.00, details: nil),
            payee: payee,
            description: "Descript",
            invoice: "B5382984-3B90-4BC4-9F7A-6A6AFA61AC25",
            custom: "C2B9FBFB-B97D-46E4-8553-522C6A25A2FC",
            paymentDescriptor: "PayScript",
            items: [],
            notify: "https://example.com/notify",
            shippingAddress: address,
            shippingMethod: "USPSParcel",
            partnerFee: PartnerFee(receiver: payee, amount: CurrencyAmount(currency: .usd, value: 2.50)),
            paymentGroup: 1,
            metadata: .init(data: ["name": "value"]),
            payment: .init(captures: nil, refunds: nil, sales: nil, authorizations: nil)
        )
        
        XCTAssertEqual(unit.reference, "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A")
        XCTAssertEqual(unit.payee, payee)
        XCTAssertEqual(unit.description, "Descript")
        XCTAssertEqual(unit.invoice, "B5382984-3B90-4BC4-9F7A-6A6AFA61AC25")
        XCTAssertEqual(unit.custom, "C2B9FBFB-B97D-46E4-8553-522C6A25A2FC")
        XCTAssertEqual(unit.paymentDescriptor, "PayScript")
        XCTAssertEqual(unit.items, [])
        XCTAssertEqual(unit.notify, "https://example.com/notify")
        XCTAssertEqual(unit.shippingAddress, address)
        XCTAssertEqual(unit.shippingMethod, "USPSParcel")
        XCTAssertEqual(unit.paymentGroup, 1)
        XCTAssertEqual(unit.metadata, .init(data: ["name": "value"]))
        XCTAssertEqual(unit.payment, .init(captures: nil, refunds: nil, sales: nil, authorizations: nil))
        XCTAssertEqual(unit.partnerFee, PartnerFee(receiver: payee, amount: CurrencyAmount(currency: .usd, value: 2.50)))
        XCTAssertEqual(unit.amount, DetailedAmount(currency: .usd, total: 5.00, details: nil))
    }
    
    func testValidations()throws {
        try XCTAssertThrowsError(Order.Unit(
            reference: String(repeating: "r", count: 257), amount: DetailedAmount(currency: .usd, total: 5.00, details: nil), payee: nil,
            description: nil, invoice: nil, custom: nil, paymentDescriptor: nil, items: [], notify: nil, shippingAddress: nil, shippingMethod: nil,
            partnerFee: nil, paymentGroup: nil, metadata: nil, payment: nil
        ))
        try XCTAssertThrowsError(Order.Unit(
            reference: "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A", amount: DetailedAmount(currency: .usd, total: 5.00, details: nil), payee: nil,
            description: String(repeating: "d", count: 128), invoice: nil, custom: nil, paymentDescriptor: nil,items: [], notify: nil, shippingAddress: nil,
            shippingMethod: nil, partnerFee: nil, paymentGroup: nil, metadata: nil, payment: nil
        ))
        try XCTAssertThrowsError(Order.Unit(
            reference: "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A", amount: DetailedAmount(currency: .usd, total: 5.00, details: nil), payee: nil, description: nil,
            invoice: nil, custom: String(repeating: "c", count: 128), paymentDescriptor: nil, items: [], notify: nil, shippingAddress: nil, shippingMethod: nil,
            partnerFee: nil, paymentGroup: nil, metadata: nil, payment: nil
        ))
        try XCTAssertThrowsError(Order.Unit(
            reference: "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A", amount: DetailedAmount(currency: .usd, total: 5.00, details: nil), payee: nil, description: nil,
            invoice: String(repeating: "i", count: 257), custom: nil, paymentDescriptor: nil, items: [], notify: nil, shippingAddress: nil, shippingMethod: nil,
            partnerFee: nil, paymentGroup: nil, metadata: nil, payment: nil
        ))
        try XCTAssertThrowsError(Order.Unit(
            reference: "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A", amount: DetailedAmount(currency: .usd, total: 5.00, details: nil), payee: nil, description: nil,
            invoice: nil, custom: nil, paymentDescriptor: String(repeating: "p", count: 23), items: [], notify: nil, shippingAddress: nil, shippingMethod: nil,
            partnerFee: nil, paymentGroup: nil, metadata: nil, payment: nil
        ))
        try XCTAssertThrowsError(Order.Unit(
            reference: "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A", amount: DetailedAmount(currency: .usd, total: 5.00, details: nil), payee: nil, description: nil,
            invoice: nil, custom: nil, paymentDescriptor: nil, items: [], notify: String(repeating: "n", count: 2049), shippingAddress: nil, shippingMethod: nil,
            partnerFee: nil, paymentGroup: nil, metadata: nil, payment: nil
        ))
        try XCTAssertThrowsError(Order.Unit(
            reference: "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A", amount: DetailedAmount(currency: .usd, total: 5.00, details: nil), payee: nil, description: nil,
            invoice: nil, custom: nil, paymentDescriptor: nil, items: [], notify: nil, shippingAddress: nil, shippingMethod: nil, partnerFee: nil,
            paymentGroup: 101, metadata: nil, payment: nil
        ))
        var unit = try Order.Unit(
            reference: "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A",
            amount: DetailedAmount(currency: .usd, total: 5.00, details: nil),
            payee: nil,
            description: "Descript",
            invoice: "B5382984-3B90-4BC4-9F7A-6A6AFA61AC25",
            custom: "C2B9FBFB-B97D-46E4-8553-522C6A25A2FC",
            paymentDescriptor: "PayScript",
            items: [],
            notify: "https://example.com/notify",
            shippingAddress: nil,
            shippingMethod: "USPSParcel",
            partnerFee: nil,
            paymentGroup: 1,
            metadata: .init(data: ["name": "value"]),
            payment: .init(captures: nil, refunds: nil, sales: nil, authorizations: nil)
        )
        
        try XCTAssertThrowsError(unit.set(\.reference <~ String(repeating: "r", count: 257)))
        try XCTAssertThrowsError(unit.set(\Order.Unit.description <~ String(repeating: "d", count: 128)))
        try XCTAssertThrowsError(unit.set(\Order.Unit.custom <~ String(repeating: "c", count: 128)))
        try XCTAssertThrowsError(unit.set(\Order.Unit.invoice <~ String(repeating: "i", count: 257)))
        try XCTAssertThrowsError(unit.set(\Order.Unit.paymentDescriptor <~ String(repeating: "p", count: 23)))
        try XCTAssertThrowsError(unit.set(\Order.Unit.notify <~ String(repeating: "n", count: 2049)))
        try XCTAssertThrowsError(unit.set(\.paymentGroup <~ 101))
        try unit.set(\.reference <~ String(repeating: "r", count: 256))
        try unit.set(\Order.Unit.description <~ String(repeating: "d", count: 127))
        try unit.set(\Order.Unit.custom <~ String(repeating: "c", count: 127))
        try unit.set(\Order.Unit.invoice <~ String(repeating: "i", count: 256))
        try unit.set(\Order.Unit.paymentDescriptor <~ String(repeating: "p", count: 22))
        try unit.set(\Order.Unit.notify <~ String(repeating: "n", count: 2048))
        try unit.set(\.paymentGroup <~ 100)
        
        XCTAssertEqual(unit.reference, String(repeating: "r", count: 256))
        XCTAssertEqual(unit.description, String(repeating: "d", count: 127))
        XCTAssertEqual(unit.custom, String(repeating: "c", count: 127))
        XCTAssertEqual(unit.invoice, String(repeating: "i", count: 256))
        XCTAssertEqual(unit.paymentDescriptor, String(repeating: "p", count: 22))
        XCTAssertEqual(unit.notify, String(repeating: "n", count: 2048))
        XCTAssertEqual(unit.paymentGroup, 100)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let payee = Payee(email: nil, merchant: nil, metadata: nil)
        let address = Address(
            recipientName: nil,
            defaultAddress: nil,
            line1: "1 Infinate Loop",
            line2: nil,
            city: "Cupertino",
            state: nil,
            country: .unitedStates,
            postalCode: "94024",
            phone: nil,
            type: nil
        )
        let unit = try Order.Unit(
            reference: "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A",
            amount: DetailedAmount(currency: .usd, total: 5.00, details: nil),
            payee: payee,
            description: "Descript",
            invoice: "B5382984-3B90-4BC4-9F7A-6A6AFA61AC25",
            custom: "C2B9FBFB-B97D-46E4-8553-522C6A25A2FC",
            paymentDescriptor: "PayScript",
            items: [],
            notify: "https://example.com/notify",
            shippingAddress: address,
            shippingMethod: "USPSParcel",
            partnerFee: PartnerFee(receiver: payee, amount: CurrencyAmount(currency: .usd, value: 2.50)),
            paymentGroup: 1,
            metadata: .init(data: [:]),
            payment: .init(captures: nil, refunds: nil, sales: nil, authorizations: nil)
        )
        
        let generated = try String(data: encoder.encode(unit), encoding: .utf8)!
        let json =
            "{\"description\":\"Descript\",\"payment_summary\":{},\"payment_descriptor\":\"PayScript\"," +
            "\"notify_url\":\"https:\\/\\/example.com\\/notify\",\"amount\":{\"currency\":\"USD\",\"total\":\"5.00\"}," +
            "\"invoice_number\":\"B5382984-3B90-4BC4-9F7A-6A6AFA61AC25\",\"metadata\":{\"supplementary_data\":[]},\"payee\":{}," +
            "\"reference_id\":\"C1C099F2-D7E7-4E19-BBBF-98DD11EA911A\",\"payment_linked_group\":1,\"shipping_address\":{\"country_code\":\"US\"," +
            "\"line1\":\"1 Infinate Loop\",\"city\":\"Cupertino\",\"postal_code\":\"94024\"},\"custom\":\"C2B9FBFB-B97D-46E4-8553-522C6A25A2FC\"," +
            "\"items\":[],\"shipping_method\":\"USPSParcel\",\"partner_fee_details\":{\"amount\":{\"value\":\"2.50\",\"currency\":\"USD\"},\"receiver\":{}}}"
        
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
        let payee = Payee(email: nil, merchant: nil, metadata: nil)
        let address = Address(
            recipientName: nil,
            defaultAddress: nil,
            line1: "1 Infinate Loop",
            line2: nil,
            city: "Cupertino",
            state: nil,
            country: .unitedStates,
            postalCode: "94024",
            phone: nil,
            type: nil
        )
        
        let json = """
        {
            "status": "PENDING",
            "reason_code": "MULTI_CURRENCY",
            "description": "Descript",
            "payment_summary": {},
            "payment_descriptor": "PayScript",
            "notify_url": "https://example.com/notify",
            "amount": {
                "currency": "USD",
                "total": "5.00"
            },
            "invoice_number": "B5382984-3B90-4BC4-9F7A-6A6AFA61AC25",
            "metadata": {
                "supplementary_data": []
            },
            "payee": {},
            "reference_id": "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A",
            "payment_linked_group": 1,
            "shipping_address": {
                "country_code": "US",
                "line1": "1 Infinate Loop",
                "city": "Cupertino",
                "postal_code": "94024"
            },
            "custom": "C2B9FBFB-B97D-46E4-8553-522C6A25A2FC",
            "items": [],
            "shipping_method": "USPSParcel",
            "partner_fee_details": {
                "amount": {
                    "value": "2.50",
                    "currency": "USD"
                },
                "receiver": {}
            }
        }
        """.data(using: .utf8)!
        
        let unit = try decoder.decode(Order.Unit.self, from: json)
        
        XCTAssertEqual(unit.status, .pending)
        XCTAssertEqual(unit.reason, .multiCurrency)
        XCTAssertEqual(unit.reference, "C1C099F2-D7E7-4E19-BBBF-98DD11EA911A")
        XCTAssertEqual(unit.payee, payee)
        XCTAssertEqual(unit.description, "Descript")
        XCTAssertEqual(unit.invoice, "B5382984-3B90-4BC4-9F7A-6A6AFA61AC25")
        XCTAssertEqual(unit.custom, "C2B9FBFB-B97D-46E4-8553-522C6A25A2FC")
        XCTAssertEqual(unit.paymentDescriptor, "PayScript")
        XCTAssertEqual(unit.items, [])
        XCTAssertEqual(unit.notify, "https://example.com/notify")
        XCTAssertEqual(unit.shippingAddress, address)
        XCTAssertEqual(unit.shippingMethod, "USPSParcel")
        XCTAssertEqual(unit.paymentGroup, 1)
        XCTAssertEqual(unit.metadata, .init(data: [:]))
        XCTAssertEqual(unit.payment, .init(captures: nil, refunds: nil, sales: nil, authorizations: nil))
        XCTAssertEqual(unit.partnerFee, PartnerFee(receiver: payee, amount: CurrencyAmount(currency: .usd, value: 2.50)))
        XCTAssertEqual(unit.amount, DetailedAmount(currency: .usd, total: 5.00, details: nil))
        
    }
    
    static var allTests: [(String, (OrderUnitTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




