import Vapor

/// A range of amounts between two
public struct MoneyRange<M>: Content, Equatable where M: Monitary {
    
    /// The minimum inclusive value of the range.
    public var minimum: M
    
    /// The maximum inclusive value for the range.
    public var maximum: M
    
    /// Creates a new `MoneyRange` instance.
    ///
    ///     MoneyRange(min: Money(code: .usd, value: "12.25"), max: Money(code: .usd, value: "50.00"))
    public init(min: M, max: M) {
        self.minimum = min
        self.maximum = max
    }
    
    /// Creates a new `MoneyRange` instance.
    ///
    ///     MoneyRange("12.25"..."50.00", currency: .usd)
    public init(_ values: ClosedRange<String>, currency: Currency)throws {
        try self.minimum = M(currency: currency, value: values.lowerBound)
        try self.maximum = M(currency: currency, value: values.upperBound)
    }
    
    enum CodingKeys: String, CodingKey {
        case minimum = "minimum_amount"
        case maximum = "maximum_amount"
    }
}
