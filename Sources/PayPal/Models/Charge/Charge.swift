import Vapor

/// An additional charge with a payment. Typically shipping or tax.
public struct Charge: Content, Equatable {
    
    /// The PayPal-generated ID for the resource.
    ///
    /// Maximum length: 128.
    public let id: String?
    
    /// The charge model type.
    public var type: ChargeType
    
    /// The currency and amount for this charge model.
    public var amount: CurrencyCodeAmount
    
    /// Creates a new `Charge` instance.
    ///
    ///     Charge(type: .tax, amount: Money(currency: .usd, value: "0.53")
    public init(type: ChargeType, amount: CurrencyCodeAmount) {
        self.id = nil
        self.type = type
        self.amount = amount
    }
}
