import XCTest
@testable import PayPal

public final class FinancialInstrumentTests: XCTestCase {
    func testInit()throws {
        let instrument = FinancialInstrument()
        
        XCTAssertNil(instrument.id)
        XCTAssertEqual(instrument.type, .bank)
        XCTAssertEqual(instrument.accountType, .checking)
        
        let instruments = FinancialInstruments(instruments: [instrument])
        
        XCTAssertEqual(instruments.instruments, [instrument])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        
        let instrument = FinancialInstrument()
        let object = try String(data: encoder.encode(instrument), encoding: .utf8)
        XCTAssertEqual(object, "{\"type\":\"BANK\",\"account_type\":\"CHECKING\"}")
        
        let instruments = FinancialInstruments(instruments: [instrument])
        let array = try String(data: encoder.encode(instruments), encoding: .utf8)
        XCTAssertEqual(array, "{\"financial_instruments\":[{\"type\":\"BANK\",\"account_type\":\"CHECKING\"}]}")
        
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let object = """
        {
            "account_type": "CHECKING",
            "type": "BANK"
        }
        """.data(using: .utf8)!
        let array = """
        {
            "financial_instruments": [
                {
                    "account_type": "CHECKING",
                    "type": "BANK"
                }
            ]
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(FinancialInstrument(), decoder.decode(FinancialInstrument.self, from: object))
        try XCTAssertEqual(FinancialInstruments(instruments: [FinancialInstrument()]), decoder.decode(FinancialInstruments.self, from: array))
    }
    
    public static var allTests: [(String, (FinancialInstrumentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

