import XCTest
@testable import PayPal

final class PayPalTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PayPal().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
