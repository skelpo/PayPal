import Vapor

internal let moneyValuePattern = "^((-?[0-9]+)|(-?([0-9]+)?[.][0-9]+))$"

/// An amount of a specified currency.
public protocol Monitary: Content, ValidationSetable, Equatable {
    
    /// The coding keys used for encoding/decoding the object.
    associatedtype CodingKeys: CodingKey
    
    /// The key path to use in validation of the `.value` property.
    static var valueKey: WritableKeyPath<Self, String> { get }
    
    /// The currency that the `Money` instance represents.
    var currency: Currency { get set }
    
    /// The amount of the currency that the class instance represents.
    ///
    /// The value, which might be:
    /// - An integer for currencies like JPY that are not typically fractional.
    /// - A decimal fraction for currencies like TND that are subdivided into thousandths.
    /// For the required number of decimal places for a currency code, see [Currency codes - ISO 4217](https://www.iso.org/iso-4217-currency-codes.html).
    ///
    /// This property should be set using the `Money.set(_:)` method, which will validate the new value
    /// before assigning it to the property.
    ///
    /// Maximum length is 32, and is must match this RegEx pattern `^((-?[0-9]+)|(-?([0-9]+)?[.][0-9]+))$`.
    var value: String { get set }
    
    /// Creates a new `Money` instance.
    ///
    ///     try Money(code: "USD", value: "12.25")
    ///
    /// - Parameters:
    ///   - code: The code for the currency of the money.
    ///   - value: The amount of the currency to represent.
    ///
    /// - Throws: `Abort(.badRequest, "Attempted to use malformed mony amount value '{value}'")`
    init(currency: Currency, value: String)throws
}

extension Monitary {
    
    /// Compares two `Money` objects, checking that the `currency`
    /// and `value` properties are equal.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.currency == rhs.currency) && (lhs.value == rhs.value)
    }
    
    /// See `ValidationSetable.setterValidations()`
    public func setterValidations() -> SetterValidations<Self> {
        var validations = SetterValidations(Self.self)
        validations.set(Self.valueKey) { value in
            guard
                value.range(of: moneyValuePattern, options: .regularExpression, range: nil, locale: nil) != nil &&
                value.count <= 32
            else {
                throw Abort(.badRequest, reason: "Attempted to use malformed money amount value '\(value)'")
            }
        }
        return validations
    }
}

/// An amount of a specified currency.
///
/// Uses `currency_code` as the `currency` property coding key.
public struct Money: Monitary {
    
    /// See `Money.valueKey`.
    public static var valueKey: WritableKeyPath<Money, String> = \.value
    
    /// See `Monitary.currency`.
    public var currency: Currency
    
    /// See `Monitary.value`.
    public var value: String
    
    /// See `Monitary.init(currency:value:)`.
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
    
    /// See `Monitary.CodingKeys`.
    public enum CodingKeys: String, CodingKey {
        case value
        case currency = "currency_code"
    }
}

/// An amount of a specified currency.
///
/// Uses `currency` as the `currency` property coding key.
public struct Amount: Monitary {

    /// See `Amount.valueKey`.
    public static var valueKey: WritableKeyPath<Amount, String> = \.value
    
    /// See `Monitary.currency`.
    public var currency: Currency
    
    /// See `Monitary.value`.
    public var value: String
    
    /// See `Monitary.init(currency:value:)`.
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
    
    /// See `Monitary.CodingKeys`.
    public enum CodingKeys: String, CodingKey {
        case value
        case currency = "currency"
    }
}
