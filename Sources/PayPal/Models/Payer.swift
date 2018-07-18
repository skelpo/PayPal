import Vapor

/// The payment information for a transaction.
public struct Payer: Content, Equatable {
    
    /// The ID of the customer-selected funding option for the payment.
    /// Value is `funding_instruments` or `funding_option_id`.
    public let fundingOption: FundingOption?
    
    
    /// The payment method.
    public var method: PaymentMethod
    
    /// An array of funding instruments.
    public var fundingInstruments: [CreditCard]?
    
    /// The payer information.
    public var info: PayerInfo?
    
    
    /// Creates a new `Payer` instance.
    ///
    ///     Payer(
    ///         method: .paypal,
    ///         fundingInstruments: [
    ///             CreditCard(
    ///                 number: "4953912847443848",
    ///                 type: "Visa",
    ///                 expireMonth: 09,
    ///                 expireYear: 2028,
    ///                 ccv2: 633,
    ///                 firstName: "Jonnas",
    ///                 lastName: "Futher",
    ///                 billingAddress: nil,
    ///                 customerID: "5FC894A2-FDA7-416D-818F-C0678C57371F"
    ///             )
    ///         ],
    ///         info: PayerInfo(
    ///             email: "payer@exmaple.com",
    ///             shippingAddress: nil,
    ///             billingAddress: Address(
    ///                 recipientName: "Puffin Billy",
    ///                 defaultAddress: true,
    ///                 line1: "89 Furnace Dr.",
    ///                 line2: nil,
    ///                 city: "Nowhere",
    ///                 state: "KS",
    ///                 countryCode: "US",
    ///                 postalCode: "66167"
    ///             )
    ///         )
    ///     )
    public init(method: PaymentMethod, fundingInstruments: [CreditCard]?, info: PayerInfo?) {
        self.fundingOption = nil
        self.method = method
        self.fundingInstruments = fundingInstruments
        self.info = info
    }
}
