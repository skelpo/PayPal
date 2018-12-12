import Vapor

/// Tax information for a transaction.
public struct Tax: Content, Equatable {
    
    /// The tax name.
    ///
    /// Maximum length: 100.
    public var name: Failable<String, Length100>
    
    /// The tax rate. Value is from `0` to `100`. Supports up to five decimal places.
    ///
    /// Minimum value: 0.
    public var percent: Failable<Decimal, RateValidation>
    
    /// The currency and amount of the calculated tax.
    public let amount: CurrencyAmount?
    
    
    /// Creates a new `Tax` instance.
    ///
    /// - Parameters:
    ///   - name: The tax name.
    ///   - percent: The tax rate.
    ///   - amount: The currency and amount of the calculated tax.
    public init(name: Failable<String, Length100>, percent: Failable<Decimal, RateValidation>, amount: CurrencyAmount?) {
        self.name = name
        self.percent = percent
        self.amount = amount
    }
}

extension Tax {
    
    /// The validation for `Tax.percent` property.
    public struct RateValidation: InRangeValidation {
        
        /// See `Validation.Supported`.
        public typealias Supported = Decimal
        
        /// The `Tax.percent` value must be 100 or less.
        public static var max: Decimal? = 100
        
        /// The `Tax.percent` value must be 0 or more.
        public static var min: Decimal? = 0
    }
}
