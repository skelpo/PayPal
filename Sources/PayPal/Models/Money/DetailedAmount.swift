import Vapor
import Core

public struct DetailedAmount {}

extension DetailedAmount {
    
    /// The additional details about a payment amount.
    public struct Detail: Content, ValidationSetable, Equatable {
        private let regex: String = "^[0-9]{,7}(\\.[0-9]{1,2})?"
        
        /// The subtotal amount for the items.
        ///
        /// If the request includes line items, this property is **required**. Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public var subtotal: String
        
        /// The shipping fee.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public var shipping: String?
        
        /// The tax.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public var tax: String?
        
        /// The handling fee.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        /// Supported for the PayPal payment method only.
        public var handlingFee: String?
        
        /// The shipping fee discount.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        /// Supported for the PayPal payment method only.
        public var shippingDiscount: String?
        
        /// The insurance fee.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        /// Supported only for the PayPal payment method.
        public var insurance: String?
        
        /// The gift wrap fee.
        ///
        /// Maximum length is 10 characters, which includes:
        /// - Seven digits before the decimal point.
        /// - The decimal point.
        /// - Two digits after the decimal point.
        public var giftWrap: String?
        
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
            case handlingFee = "handlingFee"
            case shippingDiscount = "shippingDiscount"
            case insurance = "insurance"
            case giftWrap = "giftWrap"
        }
    }
}
