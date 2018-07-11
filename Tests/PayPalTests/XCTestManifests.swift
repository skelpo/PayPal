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
        testCase(MoneyTests.allTests),
        testCase(RoleTests.allCases),
        testCase(MethodTests.allCases),
        testCase(LinkDescriptionTests.allCases),
        testCase(ExtensionsTests.allCases),
        
        // Controller Tests
        testCase(APITests.allTests),
        testCase(AuthenticationTests.allTests),
        testCase(ActivitiesTests.allTests)
    ]
}
#endif
