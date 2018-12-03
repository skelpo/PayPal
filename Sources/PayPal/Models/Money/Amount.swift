import Vapor

// MARK: - Protocols

/// A type that is used to represent an amount of money in an currency.
public protocol Amount: Codable, Equatable {
    
    /// The currency if the money amount being represented.
    var currency: Currency { get set }

    /// The amount of the currency being represented.
    var value: Decimal { get }
    
    /// The initializer signiture that should be used for types conforming to this protocol.
    ///
    /// This initializer should validate the incoming `value` value, and throw if it is invalid.
    init(currency: Currency, value: Decimal)
}

/// Coding keys that can be used for a `AmountType` type.
public protocol AmountCodingKey: CodingKey {
    
    /// The coding key for the `value` property.
    static var value: Self { get }
    
    /// The coding key for the `currency` property.
    static var currency: Self { get }
}

// MARK: - CodingKeys

/// Coding keys for a `AmountType` type that uses `currency` as the string value for coding the `currency` property.
public enum CurrencyKeys: String, AmountCodingKey {
    
    /// The actual coding key for the `value` property.
    case _value = "value"
    
    /// The actual coding key for the `currency` property.
    case _currency = "currency"
    
    /// The publicized `value` coding key so the `MoneyType` struct can access it.
    public static var value: CurrencyKeys { return ._value }
    
    /// The publicized `currency` coding key so the `MoneyType` struct can access it.
    public static var currency: CurrencyKeys  { return ._currency }
}

/// Coding keys for a `AmountType` type that uses `currency_code` as the string value for coding the `currency` property.
public enum CurrencyCodeKeys: String, AmountCodingKey {
    
    /// The actual coding key for the `value` property.
    case _value = "value"
    
    /// The actual coding key for the `currency` property.
    case _currency = "currency_code"
    
    /// The publicized `value` coding key so the `MoneyType` struct can access it.
    public static var value: CurrencyCodeKeys { return ._value }
    
    /// The publicized `currency` coding key so the `MoneyType` struct can access it.
    public static var currency: CurrencyCodeKeys  { return ._currency }
}

// MARK: - Amounts

/// A `AmountType` type that uses the `CurrencyKeys` coding keys for encoding/decoding.
public typealias CurrencyAmount = AmountType<CurrencyKeys>

/// A `AmountType` type that uses the `CurrencyCodeKeys` coding keys for encoding/decoding.
public typealias CurrencyCodeAmount = AmountType<CurrencyCodeKeys>

/// A generic type that represents an amount of any currency, where the properties support any coding keys.
public struct AmountType<Key>: Content, Amount, Equatable where Key: AmountCodingKey {
    
    /// The currency of the money that this object represents.
    public var currency: Currency
    
    /// The amount of the currency that the class instance represents.
    ///
    /// The value, which might be:
    /// - An integer for currencies like JPY that are not typically fractional.
    /// - A decimal fraction for currencies like TND that are subdivided into thousandths.
    ///
    /// For the required number of decimal places for a currency code, see
    /// [Currency codes - ISO 4217](https://www.iso.org/iso-4217-currency-codes.html).
    public private(set) var value: Decimal
    
    /// Creates an instance of `Self`.
    ///
    /// - Parameters:
    ///   - currency: The currency of the money you're representing.
    ///   - value: The amount of the currency to represent.
    public init(currency: Currency, value: Decimal) {
        self.currency = currency
        self.value = value
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let value = try container.decode(String.self, forKey: .value)
        guard let decimal = Decimal(string: value) else {
            throw PayPalError(status: .badRequest, identifier: "badValue", reason: "`value` value must be convertible to a decimal")
        }
        
        self.currency = try container.decode(Currency.self, forKey: .currency)
        self.value = decimal
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    ///
    /// This implementation rounds the `value` property before encoding it as a string. The actual `value` property is not modified.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        var rounded: Decimal = self.value
        
        if let exponent = self.currency.e {
            var value: Decimal = self.value
            NSDecimalRound(&rounded, &value, exponent, .bankers)
        }
        
        try container.encode(self.currency, forKey: .currency)
        try container.encode(String(describing: rounded), forKey: .value)
    }
}
