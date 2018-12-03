import Vapor

/// A charge model that overrides that default charge model of a `BillingAgreement` object.
public struct OverrideCharge: Content, Equatable {
    
    /// The ID of the charge model.
    public var id: String
    
    /// The updated amount and currency for this charge model.
    public var amount: CurrencyCodeAmount
    
    /// Creates a new `OverrideCharge` instance.
    ///
    ///     OverrideCharge(id: "4F64CB9E-C9B8-49E9-8217-83CDBB857534", amount: Money(currency: .usd, value: "99.99"))
    public init(id: String, amount: CurrencyCodeAmount) {
        self.id = id
        self.amount = amount
    }
}
