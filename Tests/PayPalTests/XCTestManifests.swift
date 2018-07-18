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
        testCase(CreditDebitCodeTests.allCases),
        testCase(CounterPartyTests.allCases),
        testCase(PayPalAPIErrorTests.allCases),
        testCase(PayPalAPIIdentityErrorTests.allCases),
        testCase(ActivityTests.allCases),
        testCase(ActivitiesResponseTests.allCases),
        testCase(PlanTypeTests.allCases),
        testCase(OverrideChargeTests.allCases),
        testCase(testValueValidation.allCases),
        testCase(InitialFailActionTests.allCases),
        testCase(AutoBillTests.allCases),
        testCase(MerchantPreferancesTests.allCases),
        testCase(TermTypeTests.allCases),
        testCase(TermTests.allCases),
        testCase(ChargeTypeTests.allCases),
        testCase(ChargeTests.allCases),
        testCase(PaymentTypeTests.allCases),
        testCase(FrequencyTests.allCases),
        testCase(PaymentTests.allCases),
        testCase(PlanStateTests.allCases),
        testCase(PlanTests.allCases),
        testCase(CreditCardStateTests.allCases),
        testCase(CreditCardTests.allCases),
        testCase(PayerInfoTests.allCases),
        testCase(PaymentMethodTests.allCases),
        testCase(FundingOptionTests.allCases),
        testCase(PayerTests.allCases),
        
        // Controller Tests
        testCase(APITests.allTests),
        testCase(AuthenticationTests.allTests),
        testCase(ActivitiesTests.allTests)
    ]
}
#endif
