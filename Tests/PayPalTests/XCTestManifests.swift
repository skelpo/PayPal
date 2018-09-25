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
        testCase(BillingPlanTypeTests.allCases),
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
        testCase(BillingPaymentTests.allCases),
        testCase(BillingPlanStateTests.allCases),
        testCase(BillingPlanTests.allCases),
        testCase(CreditCardStateTests.allCases),
        testCase(CreditCardTests.allCases),
        testCase(PayerInfoTests.allCases),
        testCase(PaymentMethodTests.allCases),
        testCase(FundingOptionTests.allCases),
        testCase(PayerTests.allCases),
        testCase(DetailTests.allCases),
        testCase(NewAgreementTests.allCases),
        testCase(AgreementStateTests.allTests),
        testCase(BillingAgreementTests.allCases),
        testCase(OperationTests.allCases),
        testCase(PatchTests.allCases),
        testCase(TransactionStateTests.allCases),
        testCase(TransactionTests.allCases),
        testCase(BillingPlanListTests.allCases),
        testCase(OfferTypeTests.allCases),
        testCase(OfferTests.allCases),
        testCase(MessagePosterTests.allCases),
        testCase(MessageTests.allCases),
        testCase(OutcomeCodeTests.allCases),
        testCase(DisputeOutcomeTests.allCases),
        testCase(BuyerTests.allCases),
        testCase(SellerTests.allCases),
        testCase(ItemReasonTests.allCases),
        testCase(TransactionInfoStatusTests.allCases),
        testCase(TransactionInfoTests.allCases),
        testCase(DisputeStatusTests.allCases),
        testCase(DisputeLifeCycleTests.allCases),
        testCase(DisputeChannelTests.allCases),
        testCase(CustomerDisputeTests.allCases),
        testCase(CustomerDisputeListTests.allCases),
        testCase(AcceptDisputeReasonTests.allCases),
        testCase(AcceptDisputeTests.allCases),
        testCase(AdjudicationOutcomeTests.allCases),
        testCase(CarrierTests.allCases),
        testCase(TrackingTests.allCases),
        testCase(EvidenceInfoTests.allCases),
        testCase(DocumentTests.allCases),
        testCase(EvidenceTypeTests.allCases),
        testCase(EvidenceTests.allCases),
        testCase(DisputeResolutionOfferTests.allCases),
        testCase(IDTests.allCases),
        testCase(UpdateActionTests.allCases),
        testCase(AccountTypeTests.allCases),
        testCase(UserInfoAddressTests.allCases),
        testCase(UserInfoTests.allCases),
        testCase(IdentityTests.allCases),
        testCase(InvoiceStatusTests.allCases),
        testCase(PhoneNumberTests.allCases),
        testCase(BillingInfoTests.allCases),
        testCase(ShippingInfoTests.allCases),
        testCase(TaxTests.allCases),
        testCase(DiscountTests.allCases),
        testCase(InvoiceMeasureTests.allCases),
        testCase(InvoiceItemTests.allCases),
        testCase(ShippingCostsTests.allCases),
        testCase(PaymentTermTypeTests.allCases),
        testCase(PaymentDetailTypeTests.allCases),
        testCase(PaymentTransactionTypeTests.allCases),
        testCase(PaymentDetailMethodTests.allCases),
        testCase(PaymentDetailTests.allCases),
        testCase(MetadataTests.allCases),
        testCase(FileAttachmentTests.allCases),
        testCase(PaymentSummaryTests.allCases),
        testCase(RefundDetailTests.allCases),
        testCase(InvoiceParticipantTests.allCases),
        testCase(InvoiceTests.allCases),
        testCase(InvoiceListTests.allCases),
        testCase(InvoicePaymentTests.allCases),
        testCase(CCEmailTests.allCases),
        testCase(InvoiceReminderTests.allCases),
        testCase(TemplateSettingsMetadataTests.allCases),
        testCase(TemplateSettingFieldTests.allCases),
        testCase(TemplateSettingsTests.allCases),
        testCase(TemplateDataTests.allCases),
        testCase(TemplateTests.allCases),
        testCase(TemplateListFieldsTests.allCases),
        testCase(TemplateListTests.allCases),
        testCase(InvoiceSearchTests.allCases),
        testCase(NameTests.allCases),
        testCase(BusinessOwnerAddressTypeTests.allCases),
        testCase(BusinessOwnerAddressTests.allCases),
        testCase(BusinessOwnerIDTypeTests.allCases),
        testCase(IdentificationTests.allCases),
        testCase(PhoneTypeTests.allCases),
        testCase(TypedPhoneNumberTests.allCases),
        testCase(AccountOwnerRelationshipTests.allCases),
        testCase(BusinessOwnerTests.allCases),
        testCase(BusinessTypeTests.allCases),
        testCase(BusinessSubTypeTests.allCases),
        testCase(EstablishmentTests.allCases),
        testCase(GovernmentBodyTests.allCases),
        testCase(BusinessNameTypeTests.allCases),
        testCase(BusinessNameTests.allCases),
        testCase(CustomerServiceMessageTypeTests.allCases),
        testCase(CustomerServiceMessageTests.allCases),
        testCase(CustomerServiceTests.allCases),
        testCase(TimelessDateTests.allCases),
        testCase(MoneyRangeTests.allCases),
        testCase(VenueTests.allCases),
        testCase(SalesVenueTests.allCases),
        testCase(PercentRangeTests.allCases),
        testCase(StakeholderTypeTests.allCases),
        testCase(StakeholderTests.allCases),
        testCase(DesignationTests.allCases),
        testCase(BusinessTests.allCases),
        testCase(KeyValueTests.allCases),
        testCase(EmailFrequencyTests.allCases),
        testCase(NotificationOptionTests.allCases),
        testCase(LegalAgreementTypeTests.allCases),
        testCase(LegalAgreementTests.allCases),
        testCase(PartnerOptionsTests.allCases),
        testCase(SignupOptionsTests.allCases),
        testCase(FinancialInstrumentAccountTypeTests.allCases),
        testCase(FinancialInstrumentTypeTests.allCases),
        testCase(FinancialInstrumentTests.allCases),
        testCase(PaymentReceivingPreferencesTests.allCases),
        testCase(AccountRelationTypeTests.allCases),
        testCase(AccountRelationTests.allCases),
        testCase(AccountPermissionEnumTests.allCases),
        testCase(AccountPermissionTests.allCases),
        testCase(AccountErrorDetailTests.allCases),
        testCase(AccountErrorTests.allCases),
        testCase(AccountStatusTests.allCases),
        testCase(MerchantAccountTests.allCases),
        testCase(CreatedMerchantResponseTests.allCases),
        testCase(BalanceResponseTests.allCases),
        testCase(OrderIntentTests.allCases),
        testCase(OrderStatusTests.allCases),
        testCase(OrderPaymentDisbursementTests.allCases),
        testCase(OrderPaymentDetailTests.allCases),
        testCase(OrderMetadataTests.allCases),
        testCase(RedirectsTests.allCases),
        testCase(DetailedAmountDetailTests.allCases),
        testCase(DetailedAmountTests.allCases),
        testCase(DisplayPhoneTests.allCases),
        testCase(PayeeMetadataTests.allCases),
        testCase(PayeeTests.allCases),
        testCase(OrderItemTests.allCases),
        testCase(AddressNormalizationTests.allCases),
        testCase(PartnerFeeTests.allCases),
        testCase(CaptureStatusTests.allCases),
        testCase(CaptureReasonTests.allCases),
        testCase(CaptureTests.allCases),
        testCase(RefundStatusTests.allCases),
        testCase(RefundTests.allCases),
        testCase(SaleStatusTests.allCases),
        testCase(SaleTests.allCases),
        testCase(OrderPaymentTests.allCases),
        testCase(OrderUnitStatusTests.allCases),
        testCase(OrderUnitReasonTests.allCases),
        testCase(OrderUnitTests.allCases),
        testCase(AppContextShippingTests.allCases),
        testCase(AppContextTests.allCases),
        testCase(OrderTests.allCases),
        testCase(OrderPaymentMethodTests.allCases),
        testCase(OrderPaymentStatusTests.allCases),
        testCase(OrderPayerTaxTests.allCases),
        testCase(OrderPayerInfoTests.allCases),
        testCase(CreditCardTokenTests.allCases),
        testCase(FundingInstrumentTests.allCases),
        testCase(OrderPayerTests.allCases),
        testCase(OrderPaymentRequestTests.allCases),
        testCase(PaymentIntentTests.allCases),
        testCase(PaymentStateTests.allCases),
        testCase(FraudManagementFilterTypeTests.allCases),
        testCase(FraudManagementFilterIDTests.allCases),
        testCase(FraudManagementFilterTests.allCases),
        testCase(PaymentHoldTests.allCases),
        testCase(PaymentSaleModeTests.allCases),
        testCase(PaymentSaleStateTests.allCases),
        testCase(PaymentSaleReasonTests.allCases),
        testCase(PaymentProtectionTests.allCases),
        testCase(PaymentProtectionTypeTests.allCases),
        testCase(ResourceProcessorAdviceTests.allCases),
        testCase(RelatedProcessorTests.allCases),
        testCase(RelatedResourceSaleTests.allCases),
        
        // Controller Tests
        testCase(APITests.allTests),
        testCase(AuthenticationTests.allTests),
        testCase(ActivitiesTests.allTests),
        testCase(BillingAgreementsTests.allTests),
        testCase(BillingPlansTests.allTests),
        testCase(CustomerDisputesTests.allTests),
        testCase(InvoicesTests.allTests),
        testCase(TemplatesTests.allTests),
        testCase(ManagedAccountsTests.allTests),
        testCase(OrdersTests.allTests)
    ]
}
#endif
