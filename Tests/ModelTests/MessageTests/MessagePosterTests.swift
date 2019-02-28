import XCTest
@testable import PayPal

public final class MessagePosterTests: XCTestCase {
    struct Wall: Codable {
        let poster: Message.Poster
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Message.Poster.buyer.rawValue, "BUYER")
        XCTAssertEqual(Message.Poster.seller.rawValue, "SELLER")
    }
    
    func testAllCase() {
        XCTAssertEqual(Message.Poster.allCases.count, 2)
        XCTAssertEqual(Message.Poster.allCases, [.buyer, .seller])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let buyer = try String(data: encoder.encode(Wall(poster: .buyer)), encoding: .utf8)
        let seller = try String(data: encoder.encode(Wall(poster: .seller)), encoding: .utf8)
        
        XCTAssertEqual(buyer, "{\"poster\":\"BUYER\"}")
        XCTAssertEqual(seller, "{\"poster\":\"SELLER\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let buyer = """
        {
            "poster": "BUYER"
        }
        """.data(using: .utf8)!
        let seller = """
        {
            "poster": "SELLER"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Wall.self, from: buyer).poster, .buyer)
        try XCTAssertEqual(decoder.decode(Wall.self, from: seller).poster, .seller)
    }
    
    public static var allTests: [(String, (MessagePosterTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}



