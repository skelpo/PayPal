import XCTest
import Failable
@testable import PayPal

final class NewAgreementTests: XCTestCase {
    let now = Date()
    
    func testInit()throws {
        let agreement = try NewAgreement(
            name: .init("Nia's Maggot Loaf"),
            description: .init("Weekly maggot loaf subscription"),
            start: now,
            payer: Payer(
                method: .paypal,
                fundingInstruments: nil,
                info: nil
            ),
            plan: "P-52603F876DFD4C61"
        )
        
        XCTAssertEqual(agreement.details, nil)
        XCTAssertEqual(agreement.shippingAddress, nil)
        XCTAssertEqual(agreement.overrideMerchantPreferances, nil)
        XCTAssertEqual(agreement.overrideChargeModels, nil)
        
        XCTAssertEqual(agreement.name.value, "Nia's Maggot Loaf")
        XCTAssertEqual(agreement.description.value, "Weekly maggot loaf subscription")
        XCTAssertEqual(agreement.start, now)
        XCTAssertEqual(agreement.payer, Payer(method: .paypal, fundingInstruments: nil, info: nil))
        XCTAssertEqual(agreement.plan, "P-52603F876DFD4C61")
    }
    
    func testValidations()throws {
        var agreement = try NewAgreement(
            name: .init("Nia's Maggot Loaf"),
            description: .init("Weekly maggot loaf subscription"),
            start: now,
            payer: Payer(method: .paypal, fundingInstruments: nil, info: nil),
            plan: "P-52603F876DFD4C61"
        )
        
        try XCTAssertThrowsError(agreement.name <~ String(repeating: "n", count: 129))
        try XCTAssertThrowsError(agreement.description <~ String(repeating: "d", count: 129))
        
        try agreement.name <~ "No Other Name"
        try agreement.description <~ "No other description"
        
        XCTAssertEqual(agreement.name.value, "No Other Name")
        XCTAssertEqual(agreement.description.value, "No other description")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let agreement = try NewAgreement(
            name: .init("Nia's Maggot Loaf"),
            description: .init("Weekly maggot loaf subscription"),
            start: now,
            payer: Payer(
                method: .paypal,
                fundingInstruments: nil,
                info: nil
            ),
            plan: "P-52603F876DFD4C61"
        )
        let generated = try String(data: encoder.encode(agreement), encoding: .utf8)!
        let json =
            "{\"plan\":{\"id\":\"P-52603F876DFD4C61\"},\"start_date\":\"\(now)\",\"name\":\"Nia's Maggot Loaf\"," +
            "\"description\":\"Weekly maggot loaf subscription\",\"payer\":{\"payment_method\":\"paypal\"}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let agreement = try NewAgreement(
            name: .init("Nia's Maggot Loaf"),
            description: .init("Weekly maggot loaf subscription"),
            start: now,
            payer: Payer(
                method: .paypal,
                fundingInstruments: nil,
                info: nil
            ),
            plan: "P-52603F876DFD4C61"
        )
        
        let json = """
        {
            "name": "Nia's Maggot Loaf",
            "description": "Weekly maggot loaf subscription",
            "start_date": "\(now)",
            "payer": {
                "payment_method": "paypal"
            },
            "plan": {
                "id": "P-52603F876DFD4C61"
            }
        }
        """.data(using: .utf8)!
        let nameFail = """
        {
            "name": "\(String(repeating: "n", count: 129))",
            "description": "Weekly maggot loaf subscription",
            "start_date": "\(now)",
            "payer": {
                "payment_method": "paypal"
            },
            "plan": {
                "id": "P-52603F876DFD4C61"
            }
        }
        """.data(using: .utf8)!
        let descriptionFail = """
        {
            "name": "Nia's Maggot Loaf",
            "description": "\(String(repeating: "d", count: 129))",
            "start_date": "\(now)",
            "payer": {
                "payment_method": "paypal"
            },
            "plan": {
                "id": "P-52603F876DFD4C61"
            }
        }
        """.data(using: .utf8)!
        
        try XCTAssertThrowsError(decoder.decode(NewAgreement.self, from: nameFail))
        try XCTAssertThrowsError(decoder.decode(NewAgreement.self, from: descriptionFail))
        try XCTAssertEqual(agreement, decoder.decode(NewAgreement.self, from: json))
    }
    
    static var allTests: [(String, (NewAgreementTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValidations", testValidations),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


