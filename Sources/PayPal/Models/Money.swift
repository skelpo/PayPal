import Vapor

internal let moneyValuePattern = "^((-?[0-9]+)|(-?([0-9]+)?[.][0-9]+))$"

/// An amount of a specified currency.
public final class Money: Content, Equatable {
    
    /// The currency that the `Money` instance represents.
    public var currency: Currency
    
    /// The amount of the currency that the class instance represents.
    ///
    /// The value, which might be:
    /// - An integer for currencies like JPY that are not typically fractional.
    /// - A decimal fraction for currencies like TND that are subdivided into thousandths.
    /// For the required number of decimal places for a currency code, see [Currency codes - ISO 4217](https://www.iso.org/iso-4217-currency-codes.html).
    ///
    /// Maximum length is 32, and is must match this RegEx pattern `^((-?[0-9]+)|(-?([0-9]+)?[.][0-9]+))$`.
    public private(set) var value: String
    
    /// Creates a new `Money` instance.
    ///
    ///     try Money(code: "USD", value: "12.25")
    ///
    /// - Parameters:
    ///   - code: The code for the currency of the money.
    ///   - value: The amount of the currency to represent.
    ///
    /// - Throws:
    ///   - `Abort(.badRequest, "Attempted to use invalid currency code '{code}'")`
    ///   - `Abort(.badRequest, "Attempted to use malformed mony amount value '{value}'")`
    public init(currency: Currency, value: String)throws {
        guard
            value.range(of: moneyValuePattern, options: .regularExpression, range: nil, locale: nil) != nil &&
            value.count <= 32
        else {
            throw Abort(.badRequest, reason: "Attempted to use malformed mony amount value '\(value)'")
        }
        
        self.currency = currency
        self.value = value
    }
    
    /// Creates a `Money` instance from the data container in a decoder's keyed container.
    ///
    /// This initializer uses the validations of the main `init(code:value:)` method.
    public convenience init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            currency: container.decode(Currency.self, forKey: .currency),
            value: container.decode(String.self, forKey: .value)
        )
    }
    
    /// Sets the instance's `value` property if the string passed in
    /// passes both length and structure validations.
    ///
    /// - Parameter value: The new value to validate and assing to the `value` property.
    public func setValue(to value: String)throws {
        guard
            value.range(of: moneyValuePattern, options: .regularExpression, range: nil, locale: nil) != nil &&
                value.count <= 32
            else {
                throw Abort(.badRequest, reason: "Attempted to use malformed mony amount value '\(value)'")
        }
        self.value = value
    }
    
    /// Compares two `Money` objects, checking that the `currency`
    /// and `value` properties are equal.
    public static func == (lhs: Money, rhs: Money) -> Bool {
        return (lhs.currency == rhs.currency) && (lhs.value == rhs.value)
    }
    
    enum CodingKeys: String, CodingKey {
        case value
        case currency = "currency_code"
    }
}
