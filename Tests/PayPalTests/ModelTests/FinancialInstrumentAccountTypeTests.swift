import XCTest
@testable import PayPal

typealias AccountType = FinancialInstrument.AccountType

final class FinancialInstrumentAccountTypeTests: XCTestCase {
    struct Instrument: Codable {
        let account: AccountType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(AccountType.saving.rawValue, "SAVINGS")
        XCTAssertEqual(AccountType.checking.rawValue, "CHECKING")
    }
    
    func testAllCase() {
        XCTAssertEqual(AccountType.allCases.count, 2)
        XCTAssertEqual(AccountType.allCases, [.saving, .checking])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let saving = try String(data: encoder.encode(Instrument(account: .saving)), encoding: .utf8)
        let checking = try String(data: encoder.encode(Instrument(account: .checking)), encoding: .utf8)
        
        XCTAssertEqual(saving, "{\"account\":\"SAVINGS\"}")
        XCTAssertEqual(checking, "{\"account\":\"CHECKING\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let saving = """
        {
            "account": "SAVINGS"
        }
        """.data(using: .utf8)!
        let checking = """
        {
            "account": "CHECKING"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Instrument.self, from: saving).account, .saving)
        try XCTAssertEqual(decoder.decode(Instrument.self, from: checking).account, .checking)
    }
    
    static var allTests: [(String, (FinancialInstrumentAccountTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



