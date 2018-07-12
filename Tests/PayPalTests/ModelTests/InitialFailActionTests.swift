import XCTest
@testable import PayPal

final class InitialFailActionTests: XCTestCase {
    struct Agreement: Codable {
        let action: InitialFailAction
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(InitialFailAction.cancel.rawValue, "CANCEL")
        XCTAssertEqual(InitialFailAction.continue.rawValue, "CONTINUE")
    }
    
    func testAllCase() {
        XCTAssertEqual(InitialFailAction.allCases.count, 2)
        XCTAssertEqual(InitialFailAction.allCases, [.continue, .cancel])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let cancel = try String(data: encoder.encode(Agreement(action: .cancel)), encoding: .utf8)
        let cont = try String(data: encoder.encode(Agreement(action: .continue)), encoding: .utf8)
        
        XCTAssertEqual(cancel, "{\"action\":\"CANCEL\"}")
        XCTAssertEqual(cont, "{\"action\":\"CONTINUE\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let cancel = """
        {
            "action": "CANCEL"
        }
        """.data(using: .utf8)!
        let cont = """
        {
            "action": "CONTINUE"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Agreement.self, from: cancel).action, .cancel)
        try XCTAssertEqual(decoder.decode(Agreement.self, from: cont).action, .continue)
    }
    
    static var allTests: [(String, (InitialFailActionTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


