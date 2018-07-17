import Vapor

internal let moneyValuePattern = "^((-?[0-9]+)|(-?([0-9]+)?[.][0-9]+))$"

/// An amount of a specified currency.
public struct Money: Content, ValidationSetable, Equatable {
    
    /// The currency that the `Money` instance represents.
    public var currency: Currency
    
    /// The amount of the currency that the class instance represents.
    ///
    /// The value, which might be:
    /// - An integer for currencies like JPY that are not typically fractional.
    /// - A decimal fraction for currencies like TND that are subdivided into thousandths.
    /// For the required number of decimal places for a currency code, see [Currency codes - ISO 4217](https://www.iso.org/iso-4217-currency-codes.html).
    ///
    /// This property can be set using the `Money.set(_:)` method, which will validate the new value
    /// before assigning it to the property.
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
        self.currency = currency
        self.value = value
        
        try self.set(\.value <~ value)
    }
    
    /// Creates a `Money` instance from the data container in a decoder's keyed container.
    ///
    /// This initializer uses the validations of the main `init(code:value:)` method.
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            currency: container.decode(Currency.self, forKey: .currency),
            value: container.decode(String.self, forKey: .value)
        )
    }
    
    /// Compares two `Money` objects, checking that the `currency`
    /// and `value` properties are equal.
    public static func == (lhs: Money, rhs: Money) -> Bool {
        return (lhs.currency == rhs.currency) && (lhs.value == rhs.value)
    }
    
    public static func setterValidations() -> SetterValidations<Money> {
        var validations = SetterValidations(Money.self)
        validations.set(\.value) { value in
            guard
                value.range(of: moneyValuePattern, options: .regularExpression, range: nil, locale: nil) != nil &&
                    value.count <= 32
                else {
                    throw Abort(.badRequest, reason: "Attempted to use malformed money amount value '\(value)'")
            }
        }
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case value
        case currency = "currency_code"
    }
}
