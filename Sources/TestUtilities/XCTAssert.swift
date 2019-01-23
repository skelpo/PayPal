import Failable
import PayPal
import XCTest

// MARK: - Failable

public func XCTAssertNil<T, V>(_ value: Failable<T?, V>, _ message: String? = nil) {
    XCTAssert(value.value == nil, "XCTAssertNil failed: \"\(message ?? value.debugDescription)\"")
}

public func XCTAssertNotNil<T, V>(_ value: Failable<T?, V>, _ message: String? = nil) {
    XCTAssert(value.value != nil, "XCTAssertNotNil failed: \"\(message ?? value.debugDescription)\"")
}

// MARK: - ISO8601Date

public func XCTAssertEqual(_ isoDate: ISO8601Date?, _ date: Date?, _ message: String? = nil) {
    let message = {
        return message ?? "\(isoDate?.date.description ?? "nil") is not equal to \(date?.description ?? "nil")"
    }
    
    switch (isoDate, date) {
    case let (.some(iso), .some(d)): XCTAssert(iso == d, "XCTAssertEqual failed: \"\(message())\"")
    case (.some, .none): XCTFail(message())
    case (.none, .some): XCTFail(message())
    case (.none, .none): XCTAssert(nil == nil)
    }
}
