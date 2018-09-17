import Vapor
import Core

/// The amount of a purchase which includes details such as shipping, tax, discounts, etc.
public struct DetailedAmount: Content, ValidationSetable, Equatable {
    
    /// The [three-character ISO-4217 currency code](https://developer.paypal.com/docs/integration/direct/rest/currency-codes/).
    /// PayPal does not support all currencies.
    public var currency: Currency
    
    /// The total amount charged to the payee by the payer.
    ///
    /// For refunds, represents the amount that the payee refunds to the original payer. Maximum length is 10 characters, which includes:
    /// - Seven digits before the decimal point.
    /// - The decimal point.
    /// - Two digits after the decimal point.
    public var total: String
    
    /// The additional details about the payment amount.
    public var details: Detail?
    
    
    /// Creates a new `DetailedAmount` instance.
    ///
    /// - Parameters:
    ///   - currency: The three-character ISO-4217 currency code
    ///   - total: The total amount charged to the payee by the payer.
    ///   - details: The additional details about the payment amount.
    public init(currency: Currency, total: String, details: Detail?) {
        self.currency = currency
        self.total = total
        self.details = details
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<DetailedAmount> {
        var validations = SetterValidations(DetailedAmount.self)
        
        validations.set(\.total) { total in
            guard total.range(of: "^[0-9]{0,7}(\\.[0-9]{1,2})?$", options: .regularExpression) != nil else {
                throw PayPalError(
                    status: .badRequest, identifier: "malformedString", reason: "`total` value must match RegEx pattern '^[0-9]{0,7}(\\.[0-9]{1,2})?$'"
                )
            }
        }
        
        return validations
    }
}

extension DetailedAmount {
    
    /// The additional details about a payment amount.
    public struct Detail: Content, ValidationSetable, Equatable {
        private let regex: String = "^[0-9]{0,7}(\\.[0-9]{1,2})?$"
        
        /// The subtotal amount for the items.
        ///
        /// This property can be set using the `DetailedAmount.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// If the request includes line items, this property is **required**. Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public private(set) var subtotal: String
        
        /// The shipping fee.
        ///
        /// This property can be set using the `DetailedAmount.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public private(set) var shipping: String?
        
        /// The tax.
        ///
        /// This property can be set using the `DetailedAmount.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public private(set) var tax: String?
        
        /// The handling fee.
        ///
        /// This property can be set using the `DetailedAmount.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        /// Supported for the PayPal payment method only.
        public private(set) var handlingFee: String?
        
        /// The shipping fee discount.
        ///
        /// This property can be set using the `DetailedAmount.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        /// Supported for the PayPal payment method only.
        public private(set) var shippingDiscount: String?
        
        /// The insurance fee.
        ///
        /// This property can be set using the `DetailedAmount.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        /// Supported only for the PayPal payment method.
        public private(set) var insurance: String?
        
        /// The gift wrap fee.
        ///
        /// This property can be set using the `DetailedAmount.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public private(set) var giftWrap: String?
        
        /// Creates a new `DetailAmount.Detail` instance.
        ///
        ///     DetailAmount.Detail(
        ///         subtotal: "134.56",
        ///         shipping: "5.69",
        ///         tax: "13.45",
        ///         handlingFee: "1.00",
        ///         shippingDiscount: "5.69",
        ///         insurance: "10.00",
        ///         giftWrap: "2.50"
        ///     )
        public init(
            subtotal: String,
            shipping: String? = nil,
            tax: String? = nil,
            handlingFee: String? = nil,
            shippingDiscount: String? = nil,
            insurance: String? = nil,
            giftWrap: String? = nil
        )throws {
            self.subtotal = subtotal
            self.shipping = shipping
            self.tax = tax
            self.handlingFee = handlingFee
            self.shippingDiscount = shippingDiscount
            self.insurance = insurance
            self.giftWrap = giftWrap
            
            try self.set(\.subtotal <~ subtotal)
            try self.set(\.shipping <~ shipping)
            try self.set(\.tax <~ tax)
            try self.set(\.handlingFee <~ handlingFee)
            try self.set(\.shippingDiscount <~ shippingDiscount)
            try self.set(\.insurance <~ insurance)
            try self.set(\.giftWrap <~ giftWrap)
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            try self.init(
                subtotal: container.decode(String.self, forKey: .subtotal),
                shipping: container.decodeIfPresent(String.self, forKey: .shipping),
                tax: container.decodeIfPresent(String.self, forKey: .tax),
                handlingFee: container.decodeIfPresent(String.self, forKey: .handlingFee),
                shippingDiscount: container.decodeIfPresent(String.self, forKey: .shippingDiscount),
                insurance: container.decodeIfPresent(String.self, forKey: .insurance),
                giftWrap: container.decodeIfPresent(String.self, forKey: .giftWrap)
            )
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<DetailedAmount.Detail> {
            var validations = SetterValidations(Detail.self)
            
            validations.set(\.subtotal) { subtotal in
                guard subtotal.range(of: self.regex, options: .regularExpression) != nil else {
                    throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`subtotal` value must match RegEx pattern '\(self.regex)`")
                }
            }
            validations.set(\.shipping) { shipping in
                guard let shipping = shipping else { return }
                guard shipping.range(of: self.regex, options: .regularExpression) != nil else {
                    throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`shipping` value must match RegEx pattern '\(self.regex)`")
                }
            }
            validations.set(\.tax) { tax in
                guard let tax = tax else { return }
                guard tax.range(of: self.regex, options: .regularExpression) != nil else {
                    throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`tax` value must match RegEx pattern '\(self.regex)`")
                }
            }
            validations.set(\.handlingFee) { handlingFee in
                guard let handlingFee = handlingFee else { return }
                guard handlingFee.range(of: self.regex, options: .regularExpression) != nil else {
                    throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`handlingFee` value must match RegEx pattern '\(self.regex)`")
                }
            }
            validations.set(\.shippingDiscount) { shippingDiscount in
                guard let shippingDiscount = shippingDiscount else { return }
                guard shippingDiscount.range(of: self.regex, options: .regularExpression) != nil else {
                    throw PayPalError(
                        status: .badRequest,
                        identifier: "malformedString",
                        reason: "`shippingDiscount` value must match RegEx pattern '\(self.regex)`"
                    )
                }
            }
            validations.set(\.insurance) { insurance in
                guard let insurance = insurance else { return }
                guard insurance.range(of: self.regex, options: .regularExpression) != nil else {
                    throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`insurance` value must match RegEx pattern '\(self.regex)`")
                }
            }
            validations.set(\.giftWrap) { giftWrap in
                guard let giftWrap = giftWrap else { return }
                guard giftWrap.range(of: self.regex, options: .regularExpression) != nil else {
                    throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`giftWrap` value must match RegEx pattern '\(self.regex)`")
                }
            }
            
            return validations
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
