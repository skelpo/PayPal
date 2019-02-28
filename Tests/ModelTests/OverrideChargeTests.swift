import XCTest
@testable import PayPal

public final class OverrideChargeTests: XCTestCase {
    func testInit()throws {
        let id = UUID().uuidString
        let charge = OverrideCharge(id: id, amount: CurrencyCodeAmount(currency: .usd, value: 314.15))
        
        XCTAssertEqual(charge.id, id)
        XCTAssertEqual(charge.amount, CurrencyCodeAmount(currency: .usd, value: 314.15))
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let uuid = "94F7A65B-ACEF-45AA-BA01-F141FAF40986"
        let randID = UUID().uuidString
        
        let constant = try String(data: encoder.encode(
           OverrideCharge(id: uuid, amount: CurrencyCodeAmount(currency: .eur, value: 13.54))
        ), encoding: .utf8)
        let variable = try String(data: encoder.encode(
            OverrideCharge(id: randID, amount: CurrencyCodeAmount(currency: .ang, value: 45.31))
        ), encoding: .utf8)
        
        XCTAssertEqual(constant, "{\"id\":\"94F7A65B-ACEF-45AA-BA01-F141FAF40986\",\"amount\":{\"value\":\"13.54\",\"currency_code\":\"EUR\"}}")
        XCTAssertEqual(variable, "{\"id\":\"\(randID)\",\"amount\":{\"value\":\"45.31\",\"currency_code\":\"ANG\"}}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let randID = UUID().uuidString
        
        let constant = """
        {
            "id": "94F7A65B-ACEF-45AA-BA01-F141FAF40986",
            "amount": {
                "value": "13.54",
                "currency_code": "EUR"
            }
        }
        """.data(using: .utf8)!
        let variable = """
        {
            "id": "\(randID)",
            "amount": {
                "value": "45.31",
                "currency_code": "ANG"
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(OverrideCharge(id: randID, amount: CurrencyCodeAmount(currency: .ang, value: 45.31)), decoder.decode(OverrideCharge.self, from: variable))
        
        let value = Decimal(sign: .plus, exponent: -2, significand: 1354)
        try XCTAssertEqual(
            OverrideCharge(id: "94F7A65B-ACEF-45AA-BA01-F141FAF40986", amount: CurrencyCodeAmount(currency: .eur, value: value)),
            decoder.decode(OverrideCharge.self, from: constant)
        )
    }
    
    static var allTests: [(String, (OverrideChargeTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}
