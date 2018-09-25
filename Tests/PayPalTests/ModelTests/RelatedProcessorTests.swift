import XCTest
@testable import PayPal

final class RelatedProcessorTests: XCTestCase {
    func testDecoding()throws {
        let json = """
        {
            "response_code": "8219",
            "avs_code": "3",
            "cvv_code": "g",
            "advice_code": "02_TRY_AGAIN_LATER",
            "eci_submitted": "9489",
            "vpas": "3326"
        }
        """.data(using: .utf8)!
        
        let processor = try JSONDecoder().decode(RelatedResource.ProcessorResponse.self, from: json)
        
        XCTAssertEqual(processor.code, "8219")
        XCTAssertEqual(processor.avs, "3")
        XCTAssertEqual(processor.cvv, "g")
        XCTAssertEqual(processor.advice, .tryAgain)
        XCTAssertEqual(processor.eci, "9489")
        XCTAssertEqual(processor.vpas, "3326")
    }
    
    static var allTests: [(String, (RelatedProcessorTests) -> ()throws -> ())] = [
        ("testDecoding", testDecoding)
    ]
}



