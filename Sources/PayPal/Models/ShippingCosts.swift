import Vapor

/// The shipping costs for an invoice.
public struct ShippingCosts: Content, Equatable {
    
    /// The currency and amount of the shipping charge. Value is from `0` to `1,000,000`. Supports up to two decimal places.
    public var amount: CurrencyAmount?
    
    /// The tax percentage on the shipping amount.
    public var tax: Tax?
    
    /// Creates a new `ShippingCosts` instance.
    ///
    ///     ShippingCosts(amount: Amount(currency: .usd, value: "2.50"), tax: Tax(name: "Shipping", percent: 7.5, amount: Amount(currency: .usd, value: "0.18")))
    public init(amount: CurrencyAmount?, tax: Tax?) {
        self.amount = amount
        self.tax = tax
    }
}
