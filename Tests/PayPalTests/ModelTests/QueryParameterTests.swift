import XCTest
@testable import PayPal

final class QueryParamaterTests: XCTestCase {
    func testStringContainsCount() {
        let uno = "unodounotwounothree-fouruno"
        XCTAssert(uno.contains("uno", times: 4))
        
        let ask = "ii&sdlkjl&jjrw&&fjks&kdf"
        XCTAssert(ask.contains("&", times: 5))
        
        let none = "123456789987654321"
        XCTAssert(none.contains("o", times: 0))
        
        let all = "everything"
        XCTAssert(all.contains("everything", times: 1))
        
        let last = "everylastthing8"
        XCTAssert(last.contains("thing8", times: 1))
        XCTAssert(last.contains("8", times: 1))
        
        let first = "<:>++(-)++<:>"
        XCTAssert(first.contains("<:>++", times: 1))
        XCTAssert(first.contains("<", times: 2))
    }
    
    func testEncoding() {
        let now = Date()
        let end = now + (60 * 60 * 24 * 7)
        
        let parameters = QueryParamaters(
            count: 30,
            startTime: now,
            endTime: end,
            page: 0,
            pageSize: 15,
            totalCountRequired: true,
            sortBy: "title",
            sortOrder: .ascending,
            startID: "0",
            startIndex: 0,
            custom: ["hello": "world"]
        )
        let string = parameters.encode()
        
        XCTAssert(string.contains("count=30"))
        XCTAssert(string.contains("end_time=\(end.iso8601)"))
        XCTAssert(string.contains("next_page_token=0"))
        XCTAssert(string.contains("page_size=15"))
        XCTAssert(string.contains("total_count_required=true"))
        XCTAssert(string.contains("sort_by=title"))
        XCTAssert(string.contains("sort_order=ascending"))
        XCTAssert(string.contains("start_id=0"))
        XCTAssert(string.contains("start_index=0"))
        XCTAssert(string.contains("start_time=\(now.iso8601)"))
        XCTAssert(string.contains("hello=world"))
        XCTAssert(string.contains("&", times: 10))
    }
    
    func testEncodingSpeed() {
        let now = Date()
        let end = now + (60 * 60 * 24 * 7)
        
        let parameters = QueryParamaters(
            count: 30,
            startTime: now,
            endTime: end,
            page: 0,
            pageSize: 15,
            totalCountRequired: true,
            sortBy: "title",
            sortOrder: .ascending,
            startID: "0",
            startIndex: 0,
            custom: ["hello": "world"]
        )
        
        measure {
            for _ in 0...100_000 {
                _ = parameters.encode()
            }
        }
    }
    
    static var allTests: [(String, (QueryParamaterTests) -> ()throws -> ())] = [
        ("testStringContainsCount", testStringContainsCount),
        ("testEncoding", testEncoding),
        ("testEncodingSpeed", testEncodingSpeed)
    ]
}

extension String {
    func contains<S>(_ string: S, times n: Int) -> Bool where S: StringProtocol {
        var i = self.startIndex
        var matchEnd = self.index(self.startIndex, offsetBy: string.count - 1)
        var matchs = 0
        
        while matchEnd < self.endIndex {
            if self[i] == string.first {
                if self[i...matchEnd] == string {
                    matchs += 1
                }
            }
            
            i = self.index(i, offsetBy: 1)
            matchEnd = self.index(i, offsetBy: string.count - 1)
        }
        
        return matchs == n
    }
}
