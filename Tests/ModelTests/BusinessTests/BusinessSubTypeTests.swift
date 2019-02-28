import XCTest
@testable import PayPal

public final class BusinessSubTypeTests: XCTestCase {
    struct Busi: Codable {
        let type: Business.SubType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Business.SubType.assoIncorporated.rawValue, "ASSO_TYPE_INCORPORATED")
        XCTAssertEqual(Business.SubType.assoNonIncorporated.rawValue, "ASSO_TYPE_NON_INCORPORATED")
        XCTAssertEqual(Business.SubType.govtEmanation.rawValue, "GOVT_TYPE_EMANATION")
        XCTAssertEqual(Business.SubType.govtEntity.rawValue, "GOVT_TYPE_ENTITY")
        XCTAssertEqual(Business.SubType.govtEstdComm.rawValue, "GOVT_TYPE_ESTD_COMM")
        XCTAssertEqual(Business.SubType.govtEstdFc.rawValue, "GOVT_TYPE_ESTD_FC")
        XCTAssertEqual(Business.SubType.govtEstdStTr.rawValue, "GOVT_TYPE_ESTD_ST_TR")
        XCTAssertEqual(Business.SubType.unselected.rawValue, "UNSELECTED")
    }
    
    func testAllCase() {
        XCTAssertEqual(Business.SubType.allCases.count, 8)
        XCTAssertEqual(Business.SubType.allCases, [
            .assoIncorporated, .assoNonIncorporated, .govtEmanation, .govtEntity, .govtEstdComm, .govtEstdFc, .govtEstdStTr, .unselected
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        
        let assoIncorporated = try String(data: encoder.encode(Busi(type: .assoIncorporated)), encoding: .utf8)
        let govtEmanation = try String(data: encoder.encode(Busi(type: .govtEmanation)), encoding: .utf8)
        
        XCTAssertEqual(assoIncorporated, "{\"type\":\"ASSO_TYPE_INCORPORATED\"}")
        XCTAssertEqual(govtEmanation, "{\"type\":\"GOVT_TYPE_EMANATION\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let govtEstdComm = """
        {
            "type": "GOVT_TYPE_ESTD_COMM"
        }
        """.data(using: .utf8)!
        let govtEstdStTr = """
        {
            "type": "GOVT_TYPE_ESTD_ST_TR"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Busi.self, from: govtEstdComm).type, .govtEstdComm)
        try XCTAssertEqual(decoder.decode(Busi.self, from: govtEstdStTr).type, .govtEstdStTr)
    }
    
    static var allTests: [(String, (BusinessSubTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}




