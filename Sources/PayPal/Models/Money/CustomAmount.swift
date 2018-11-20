import Vapor

/// A monitary amount with a custom label.
public struct CustomAmount<M>: Content, Equatable where M: Monitary {
    
    /// The custom amount label.
    ///
    /// Maximum length: 50.
    public var label: String?
    
    /// The currency and amount of the custom value. Value is from `-1,000,000` to `1,000,000`. Supports up to two decimal places.
    public var amount: M?
    
    /// Creates a new `CustomAmount` instance.
    ///
    ///     CustomAmount<Amount>(label: "Some Text", amount: Amount(currency: .usd, value: "25.50"))
    public init(label: String?, amount: M?) {
        self.label = label
        self.amount = amount
    }
}
