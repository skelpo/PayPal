import Vapor
import Core

/// The amount of a purchase which includes details such as shipping, tax, discounts, etc.
public struct DetailedAmount: Content, Equatable {
    
    /// The currency and amount information for the intance.
    ///
    /// The amount's `value` property is the total amount charged to the payee by the payer.
    ///
    /// The proprties of this property (`value` and `currency`) are encoded/decoded inline with
    /// the rest of this type's properties. The coding-key for `value` is `total`.
    public var amount: CurrencyAmount
    
    /// The additional details about the payment amount.
    public var details: Detail?
    
    
    /// Creates a new `DetailedAmount` instance.
    ///
    /// - Parameters:
    ///   - currency: The three-character ISO-4217 currency code
    ///   - total: The total amount charged to the payee by the payer.
    ///   - details: The additional details about the payment amount.
    public init(currency: Currency, total: Decimal, details: Detail?) {
        self.amount = CurrencyAmount(currency: currency, value: total)
        self.details = details
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.details = try container.decodeIfPresent(Detail.self, forKey: .details)
        self.amount = CurrencyAmount(
            currency: try container.decode(Currency.self, forKey: .currency),
            value: try Detail.decimal(from: container.decode(String.self, forKey: .total))
        )
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(String(describing: self.amount.value), forKey: .total)
        try container.encode(self.amount.currency, forKey: .currency)
        try container.encodeIfPresent(self.details, forKey: .details)
    }
    
    enum CodingKeys: String, CodingKey {
        case currency, total, details
    }
}

extension DetailedAmount {
    
    /// The additional details about a payment amount.
    public struct Detail: Content, Equatable {
        internal static func decimal(from value: String)throws -> Decimal {
            guard Double(value) != nil, var decimal = Decimal(string: value) else {
                throw PayPalError(status: .badRequest, identifier: "badValue", reason: "Unable to convert string `\(value)` to a decimal number")
            }
            guard decimal < 10_000_000 else {
                throw PayPalError(status: .badRequest, identifier: "invalidDecimal", reason: "Decimal value must be less than 10,000,000")
            }
            
            var rounded = decimal
            NSDecimalRound(&rounded, &decimal, 2, .bankers)
            
            if value == "9876543.210" {
                print("value:", value, ", decimal:", decimal, ", rounded:", rounded)
            }
            
            return rounded
        }
        
        internal static func string(from value: Decimal?)throws -> String? {
            guard var decimal = value else { return nil }
            guard decimal < 10_000_000 else {
                throw PayPalError(status: .internalServerError, identifier: "invalidDecimal", reason: "Decimal value must be less than 10,000,000")
            }
            
            var rounded = decimal
            NSDecimalRound(&rounded, &decimal, 2, .bankers)
            
            return String(describing: rounded)
        }
        
        internal static func decimal(from value: String?)throws -> Decimal? {
            if let string = value { return try self.decimal(from: string) as Decimal } else { return nil }
        }
        
        /// The subtotal amount for the items.
        ///
        /// If the request includes line items, this property is **required**. Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public var subtotal: Decimal
        
        /// The shipping fee.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public var shipping: Decimal?
        
        /// The tax.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public var tax: Decimal?
        
        /// The handling fee.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        /// Supported for the PayPal payment method only.
        public var handlingFee: Decimal?
        
        /// The shipping fee discount.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        /// Supported for the PayPal payment method only.
        public var shippingDiscount: Decimal?
        
        /// The insurance fee.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        /// Supported only for the PayPal payment method.
        public var insurance: Decimal?
        
        /// The gift wrap fee.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public var giftWrap: Decimal?
        
        /// Creates a new `DetailAmount.Detail` instance.
        ///
        /// - Parameters:
        ///   - subtotal: The subtotal amount for the items in an item list.
        ///   - shipping: The shipping fee.
        ///   - tax: The tax.
        ///   - handlingFee: The handling fee.
        ///   - shippingDiscount: The discount for shipping.
        ///   - insurance: The insurance fee.
        ///   - giftWrap: The gift wrap fee.
        public init(
            subtotal: Decimal,
            shipping: Decimal? = nil,
            tax: Decimal? = nil,
            handlingFee: Decimal? = nil,
            shippingDiscount: Decimal? = nil,
            insurance: Decimal? = nil,
            giftWrap: Decimal? = nil
        ) {
            self.subtotal = subtotal
            self.shipping = shipping
            self.tax = tax
            self.handlingFee = handlingFee
            self.shippingDiscount = shippingDiscount
            self.insurance = insurance
            self.giftWrap = giftWrap
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.subtotal         = try Detail.decimal(from: container.decode(String.self, forKey: .subtotal))
            self.shipping         = try Detail.decimal(from: container.decodeIfPresent(String.self, forKey: .shipping))
            self.tax              = try Detail.decimal(from: container.decodeIfPresent(String.self, forKey: .tax))
            self.handlingFee      = try Detail.decimal(from: container.decodeIfPresent(String.self, forKey: .handlingFee))
            self.shippingDiscount = try Detail.decimal(from: container.decodeIfPresent(String.self, forKey: .shippingDiscount))
            self.insurance        = try Detail.decimal(from: container.decodeIfPresent(String.self, forKey: .insurance))
            self.giftWrap         = try Detail.decimal(from: container.decodeIfPresent(String.self, forKey: .giftWrap))
        }
        
        /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
        public func encode(to encoder: Encoder)throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            if let value = try Detail.string(from: self.subtotal)         { try container.encode(value, forKey: .subtotal) }
            if let value = try Detail.string(from: self.shipping)         { try container.encodeIfPresent(value, forKey: .shipping) }
            if let value = try Detail.string(from: self.tax)              { try container.encodeIfPresent(value, forKey: .tax) }
            if let value = try Detail.string(from: self.handlingFee)      { try container.encodeIfPresent(value, forKey: .handlingFee) }
            if let value = try Detail.string(from: self.shippingDiscount) { try container.encodeIfPresent(value, forKey: .shippingDiscount) }
            if let value = try Detail.string(from: self.insurance)        { try container.encodeIfPresent(value, forKey: .insurance) }
            if let value = try Detail.string(from: self.giftWrap)         { try container.encodeIfPresent(value, forKey: .giftWrap) }
        }
        
        enum CodingKeys: String, CodingKey {
            case subtotal = "subtotal"
            case shipping = "shipping"
            case tax = "tax"
            case handlingFee = "handling_fee"
            case shippingDiscount = "shipping_discount"
            case insurance = "insurance"
            case giftWrap = "gift_wrap"
        }
    }
}
