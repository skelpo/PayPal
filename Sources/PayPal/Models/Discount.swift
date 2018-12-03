import Vapor

/// A discount on an item in a transaction.
public struct Discount<M>: Content, Equatable where M: Amount {
    
    /// The discount as a percentage value. Value is from `0` to `100`. Supports up to five decimal places.
    public var percent: Decimal?
    
    /// The currency and amount of the invoice-level discount. Value is from `0` to `1000000`. Supports up to two decimal places.
    public var amount: M?
    
    /// Creates a new `Discount` instance.
    ///
    ///     Discount(percent: 15, amount: Amount(currency: .usd, value: "1.25"))
    public init(percent: Decimal?, amount: M?) {
        self.percent = percent
        self.amount = amount
    }
}
