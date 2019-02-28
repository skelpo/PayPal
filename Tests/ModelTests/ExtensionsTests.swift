import XCTest
@testable import PayPal

public final class ExtensionsTests: XCTestCase {
    let extensions = Extensions(
        paymentProperties: PaymentProperties(
            creditDebitCode: .credit,
            buyerNotes: nil,
            orderID: "E07E1836-A7B8-42B5-8870-BDFDAAEB4AEC",
            billingAgreementID: "31E98315-0359-4775-9BB2-769289B1C2F0",
            externalSubType: .purchase,
            invoiceNumber: "8282D36F-5608-4D16-8185-2A8CB0E818BD"
        ),
        requestMoneyProperties: MoneyRequestProperties(
            role: .requestee
        ),
        invoiceProperties: InvoiceProperties(
            role: .requester,
            invoiceNumber: "71191D6B-14AB-44F9-8B5A-659FC9C984CD"
        ),
        orderProperties: OrderProperties(
            role: .payer
        )
    )
    
    func testInit()throws {
        XCTAssertEqual(extensions.paymentProperties, PaymentProperties(
            creditDebitCode: .credit,
            buyerNotes: nil,
            orderID: "E07E1836-A7B8-42B5-8870-BDFDAAEB4AEC",
            billingAgreementID: "31E98315-0359-4775-9BB2-769289B1C2F0",
            externalSubType: .purchase,
            invoiceNumber: "8282D36F-5608-4D16-8185-2A8CB0E818BD"
        ))
        XCTAssertEqual(extensions.invoiceProperties, InvoiceProperties(
            role: .requester,
            invoiceNumber: "71191D6B-14AB-44F9-8B5A-659FC9C984CD"
        ))
        XCTAssertEqual(extensions.requestMoneyProperties, MoneyRequestProperties(role: .requestee))
        XCTAssertEqual(extensions.orderProperties, OrderProperties(role: .payer))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let generated = try String(data: encoder.encode(self.extensions), encoding: .utf8)!
        let json =
            "{\"payment_properties\":{\"billing_agreement_id\":\"31E98315-0359-4775-9BB2-769289B1C2F0\",\"order_id\":\"E07E1836-A7B8-42B5-8870-BDFDAAEB4AEC\"," +
            "\"credit_debit_code\":\"CREDIT\",\"external_sub_type\":\"PURCHASE\"," +
            "\"invoice_number\":\"8282D36F-5608-4D16-8185-2A8CB0E818BD\"},\"request_money_properties\":{\"role\":\"REQUESTEE\"}," +
            "\"order_properties\":{\"role\":\"PAYER\"}," +
            "\"invoice_properties\":{\"invoice_number\":\"71191D6B-14AB-44F9-8B5A-659FC9C984CD\",\"role\":\"REQUESTER\"}}"
        
        // JSON is 434 characters long.
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let ext = """
        {
            "payment_properties": {
                "credit_debit_code": "CREDIT",
                "order_id": "E07E1836-A7B8-42B5-8870-BDFDAAEB4AEC",
                "billing_agreement_id": "31E98315-0359-4775-9BB2-769289B1C2F0",
                "external_sub_type": "PURCHASE",
                "invoice_number": "8282D36F-5608-4D16-8185-2A8CB0E818BD"
            },
            "request_money_properties": {
                 "role": "REQUESTEE"
            },
            "invoice_properties": {
                "role": "REQUESTER",
                "invoice_number": "71191D6B-14AB-44F9-8B5A-659FC9C984CD"
            },
            "order_properties": {
                "role": "PAYER"
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(self.extensions, decoder.decode(Extensions.self, from: ext))
    }
    
    public static var allTests: [(String, (ExtensionsTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

