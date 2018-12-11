import Vapor

/// A monitary amount with a custom label.
public struct CustomAmount<Keys>: Content, Equatable where Keys: AmountCodingKey {
    
    /// The custom amount label.
    ///
    /// Maximum length: 50.
    public var label: Failable<String?, NotNilValidate<Length50>>
    
    /// The currency and amount of the custom value. Value is from `-1,000,000` to `1,000,000`. Supports up to two decimal places.
    public var amount: Failable<AmountType<Keys>?, NotNilValidate<CurrencyMillion<Keys>>>
    
    /// Creates a new `CustomAmount` instance.
    ///
    /// - Parameters:
    ///   - label: The custom amount label.
    ///   - amount: The currency and amount of the custom value.
    public init(label: Failable<String?, NotNilValidate<Length50>>, amount: Failable<AmountType<Keys>?, NotNilValidate<CurrencyMillion<Keys>>>) {
        self.label = label
        self.amount = amount
    }
}
