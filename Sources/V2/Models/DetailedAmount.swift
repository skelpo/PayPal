import Foundation
import PayPal

/// A currency amount with a breakdown that provides details about shipping, handling, tax, etc.
public struct DetailedAmount: Codable {
    
    /// The [three-character ISO-4217 currency code](https://developer.paypal.com/docs/integration/direct/rest/currency-codes/)
    /// that identifies the currency.
    public var currency: Currency
    
    /// The amount of the given currency to represent.
    ///
    /// The value, which might be:
    /// - An integer for currencies like `JPY` that are not typically fractional.
    /// - A decimal fraction for currencies like `TND` that are subdivided into thousandths.
    ///
    /// For the required number of decimal places for a currency code, see
    /// [Currency Codes](https://developer.paypal.com/docs/integration/direct/rest/currency-codes/).
    public var value: Decimal
    
    /// The breakdown of the amount. Breakdown provides details such as total item amount, total tax amount, shipping,
    /// handling, insurance, and discounts, if any.
    public var breakdown: Breakdown?
    
    /// Creates a new `DetailedAmount` instance.
    ///
    /// - Parameters:
    ///   - currency: The three-character ISO-4217 currency code that identifies the currency.
    ///   - value: The amount of the given currency to represent.
    ///   - breakdown: The breakdown of the amount.
    public init(currency: Currency, value: Decimal, breakdown: Breakdown?) {
        self.currency = currency
        self.value = value
        self.breakdown = breakdown
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value = try container.decode(String.self, forKey: .value)
        guard let decimal = Decimal(string: value) else {
            throw DecodingError.dataCorruptedError(
                forKey: .value,
                in: container,
                debugDescription: "`value` string must be convertible to a decimal type"
            )
        }
        
        self.currency = try container.decode(Currency.self, forKey: .currency)
        self.breakdown = try container.decode(Breakdown.self, forKey: .breakdown)
        self.value = decimal
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    ///
    /// This implementation rounds the `value` property before encoding it as a string.
    /// The actual `value` property is not modified.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var rounded: Decimal = self.value
        
        if let exponent = self.currency.e {
            var value: Decimal = self.value
            NSDecimalRound(&rounded, &value, exponent, .bankers)
        }
        
        try container.encode(self.currency, forKey: .currency)
        try container.encode(self.breakdown, forKey: .breakdown)
        try container.encode(rounded.description, forKey: .value)
    }
    
    /// The breakdown of the amount of a purchase unit in an order.
    public struct Breakdown: Codable {
        
        /// The subtotal for all items. Required if the request includes `purchase_units[].items[].unit_amount`.
        /// Must equal the sum of `(items[].unit_amount * items[].quantity)` for all items.
        public var total: CurrencyCodeAmount?
        
        /// The shipping fee for all items within a given `purchase_unit`.
        public var shipping: CurrencyCodeAmount?
        
        /// The handling fee for all items within a given `purchase_unit`.
        public var handling: CurrencyCodeAmount?
        
        /// The total tax for all items. Required if the request includes `purchase_units.items.tax`.
        /// Must equal the sum of `(items[].tax * items[].quantity)` for all items.
        public var tax: CurrencyCodeAmount?
        
        /// The insurance fee for all items within a given `purchase_unit`.
        public var insurance: CurrencyCodeAmount?
        
        /// The shipping discount for all items within a given `purchase_unit`.
        public var shippingDiscount: CurrencyCodeAmount?
        
        /// Creates a new `DetailedAmount.Breakdown` instance.
        ///
        /// - Parameters:
        ///   - total: The subtotal for all items.
        ///   - shipping: The shipping fee for all items within a given `purchase_unit`.
        ///   - handling: The handling fee for all items within a given `purchase_unit`.
        ///   - tax: The total tax for all items.
        ///   - insurance: The insurance fee for all items within a given `purchase_unit`.
        ///   - shippingDiscount: The shipping discount for all items within a given `purchase_unit`.
        public init(
            total: CurrencyCodeAmount?,
            shipping: CurrencyCodeAmount?,
            handling: CurrencyCodeAmount?,
            tax: CurrencyCodeAmount?,
            insurance: CurrencyCodeAmount?,
            shippingDiscount: CurrencyCodeAmount?
        ) {
            self.total = total
            self.shipping = shipping
            self.handling = handling
            self.tax = tax
            self.insurance = insurance
            self.shippingDiscount = shippingDiscount
        }
        
        enum CodingKeys: String, CodingKey {
            case shipping, handling, insurance
            case total = "item_total"
            case tax = "tax_total"
            case shippingDiscount = "shipping_discount"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case value, breakdown
        case currency = "currency_code"
    }
}
