import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PayPalTests.allTests),
        
        // Config Tests
        testCase(EnvironmentTests.allTests),
        testCase(ProviderTests.allTests),
        
        // Model Tests
        testCase(CurrencyTests.allTests),
        
        // Controller Tests
        testCase(AuthenticationTests.allTests),
        testCase(APITests.allTests),
    ]
}
#endif
