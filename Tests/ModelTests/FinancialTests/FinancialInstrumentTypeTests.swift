import XCTest
@testable import PayPal

typealias InstrumentType = FinancialInstrument.InstrumentType

public final class FinancialInstrumentTypeTests: XCTestCase {
    struct Instrument: Codable {
        let type: InstrumentType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(InstrumentType.bank.rawValue, "BANK")
    }
    
    func testAllCase() {
        XCTAssertEqual(InstrumentType.allCases.count, 1)
        XCTAssertEqual(InstrumentType.allCases, [.bank])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let bank = try String(data: encoder.encode(Instrument(type: .bank)), encoding: .utf8)
        
        XCTAssertEqual(bank, "{\"type\":\"BANK\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let bank = """
        {
            "type": "BANK"
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(decoder.decode(Instrument.self, from: bank).type, .bank)
    }
    
    static var allTests: [(String, (FinancialInstrumentTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




