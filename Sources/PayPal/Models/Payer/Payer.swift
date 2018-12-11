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
    /// - Parameters:
    ///   - method: The payment method.
    ///   - fundingInstruments: An array of funding instruments.
    ///   - info: The payer information.
    public init(method: PaymentMethod, fundingInstruments: [CreditCard]?, info: PayerInfo?) {
        self.fundingOption = nil
        self.method = method
        self.fundingInstruments = fundingInstruments
        self.info = info
    }
    
    enum CodingKeys: String, CodingKey {
        case fundingOption = "funding_option_id"
        case method = "payment_method"
        case fundingInstruments = "funding_instruments"
        case info = "payer_info"
    }
}
