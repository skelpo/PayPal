import XCTest
@testable import PayPal

final class FinancialInstrumentTests: XCTestCase {
    func testInit()throws {
        let id = UUID().uuidString
        let instrument = FinancialInstrument(id: id)
        
        XCTAssertEqual(instrument.id, id)
        XCTAssertEqual(instrument.type, .bank)
        XCTAssertEqual(instrument.accountType, .checking)
        
        let instruments = FinancialInstruments(instruments: [instrument])
        
        XCTAssertEqual(instruments.instruments, [instrument])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        
        let id = UUID().uuidString
        let instrument = FinancialInstrument(id: id)
        let object = try String(data: encoder.encode(instrument), encoding: .utf8)
        XCTAssertEqual(object, "{\"type\":\"BANK\",\"id\":\"\(id)\",\"account_type\":\"CHECKING\"}")
        
        let instruments = FinancialInstruments(instruments: [instrument])
        let array = try String(data: encoder.encode(instruments), encoding: .utf8)
        XCTAssertEqual(array, "{\"financial_instruments\":[{\"type\":\"BANK\",\"id\":\"\(id)\",\"account_type\":\"CHECKING\"}]}")
        
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let id = UUID().uuidString
        
        let object = """
        {
            "account_type": "CHECKING",
            "type": "BANK",
            "id": "\(id)"
        }
        """.data(using: .utf8)!
        let array = """
        {
            "financial_instruments": [
                {
                    "account_type": "CHECKING",
                    "type": "BANK",
                    "id": "\(id)"
                }
            ]
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(FinancialInstrument(id: id), decoder.decode(FinancialInstrument.self, from: object))
        try XCTAssertEqual(FinancialInstruments(instruments: [FinancialInstrument(id: id)]), decoder.decode(FinancialInstruments.self, from: array))
    }
    
    static var allTests: [(String, (FinancialInstrumentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

