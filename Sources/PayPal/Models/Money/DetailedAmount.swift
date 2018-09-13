import Vapor

public struct DetailedAmount {}

extension DetailedAmount {
    public struct Detail: Content, Equatable {
        public var subtotal: String?
        public var shipping: String?
        public var tax: String?
        public var handlingFee: String?
        public var shippingDiscount: String?
        public var insurance: String?
        public var giftWrap: String?
        
        public init(
            subtotal: String?,
            shipping: String?,
            tax: String?,
            handlingFee: String?,
            shippingDiscount: String?,
            insurance: String?,
            giftWrap: String?
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
