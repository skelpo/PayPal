import Vapor

public struct DetailedAmount {}

extension DetailedAmount {
    
    /// The additional details about a payment amount.
    public struct Detail: Content, Equatable {
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
    }
}
