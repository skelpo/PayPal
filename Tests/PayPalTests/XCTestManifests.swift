import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PayPalTests.allTests),
        testCase(EnvironmentTests.allTests),
        testCase(ProviderTests.allTests),
        testCase(AuthenticationTests.allTests),
        testCase(APITests.allTests)
    ]
}
#endif
