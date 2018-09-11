import XCTest
@testable import PayPal

final class FinancialInstrumentTests: XCTestCase {
    func testInit()throws {
        let id = UUID().uuidString
        let instrument = FinancialInstrument(id: id)
        
        XCTAssertEqual(instrument.id, id)
        XCTAssertEqual(instrument.type, .bank)
        XCTAssertEqual(instrument.accountType, .checking)
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let id = UUID().uuidString
        let instrument = FinancialInstrument(id: id)
        let generated = try String(data: encoder.encode(instrument), encoding: .utf8)
        
        XCTAssertEqual(generated, "{\"account_type\":\"CHECKING\",\"type\":\"BANK\",\"id\":\"\(id)\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "account_type": "CHECKING",
            "type": "BANK",
            "id": "\(id)"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(FinancialInstrument(id: id), decoder.decode(FinancialInstrument.self, from: json))
    }
    
    static var allTests: [(String, (FinancialInstrumentTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

