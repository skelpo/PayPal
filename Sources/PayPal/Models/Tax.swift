import Vapor

/// Tax information for a transaction.
public struct Tax: Content, Equatable {
    
    /// The tax name.
    ///
    /// Maximum length: 100.
    public var name: String
    
    /// The tax rate. Value is from `0` to `100`. Supports up to five decimal places.
    ///
    /// Minimum value: 0.
    public var percent: Int
    
    /// The currency and amount of the calculated tax.
    public let amount: Amount?
    
    
    /// Creates a new `Tax` instance.
    ///
    ///     Tax(name: "Sales", percent: 10, amount: Amount(code: .usd, value: "0.59"))
    public init(name: String, percent: Int, amount: Amount?) {
        self.name = name
        self.percent = percent
        self.amount = amount
    }
}
