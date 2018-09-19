import Vapor

extension Order {
    public struct Unit: Content, Equatable {
        public let status: Status?
        public let reason: Reason?
        
        public var reference: String
        public var amount: DetailedAmount
        public var payee: Payee?
        public var description: String?
        public var invoice: String?
        public var paymentDescriptor: String?
        public var items: [Item]?
        public var notify: String?
        public var shippingAddress: Address?
        public var shippingMethod: String?
        public var partnerFee: PartnerFee?
        public var paymentGroup: Int?
        public var metadata: Metadata?
        public var payment: Payment?
        
        public init(
            reference: String,
            amount: DetailedAmount,
            payee: Payee?,
            description: String?,
            invoice: String?,
            paymentDescriptor: String?,
            items: [Item]?,
            notify: String?,
            shippingAddress: Address?,
            shippingMethod: String?,
            partnerFee: PartnerFee?,
            paymentGroup: Int?,
            metadata: Metadata?,
            payment: Payment?
        ) {
            self.status = nil
            self.reason = nil
            self.reference = reference
            self.amount = amount
            self.payee = payee
            self.description = description
            self.invoice = invoice
            self.paymentDescriptor = paymentDescriptor
            self.items = items
            self.notify = notify
            self.shippingAddress = shippingAddress
            self.shippingMethod = shippingMethod
            self.partnerFee = partnerFee
            self.paymentGroup = paymentGroup
            self.metadata = metadata
            self.payment = payment
        }
    }
}

extension Order.Unit {
    
    /// The transaction state of a purchase unit.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The transaction was not processed.
        case notProcessed = "NOT_PROCESSED"
        
        /// The transaction is pending.
        case pending = "PENDING"
        
        /// The transaction was declined and voided.
        case voided = "VOIDED"
        
        /// Payment for the transaction was not authorized.
        case authorized = "AUTHORIZED"
        
        /// Payment for the transaction was captured or is pending capture.
        case captured = "CAPTURED"
    }
}

extension Order.Unit {
    
    /// The reason code for a transaction status of `PENDING` or `REVERSED`. 
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// The transaction state is `PENDING` or `REVERSED` due to an unconfirmed payer shipping address.
        case unconfirmedAddress = "PAYER_SHIPPING_UNCONFIRMED"
        
        /// The transaction state is `PENDING` or `REVERSED` because it is a multi-currency transaction.
        case multiCurrency = "MULTI_CURRENCY"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a risk review.
        case risk = "RISK_REVIEW"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a regulatory review.
        case regulatory = "REGULATORY_REVIEW"
        
        /// The transaction state is `PENDING` or `REVERSED` because verification is required.
        case verification = "VERIFICATION_REQUIRED"
        
        /// The transaction state is `PENDING` or `REVERSED` because the transaction is an order.
        case order = "ORDER"
        
        /// The transaction state is `PENDING` or `REVERSED` due to another reason.
        case other = "OTHER"
        
        /// The transaction state is `PENDING` or `REVERSED` because it was declined by a policy.
        case declinedByPolicy = "DECLINED_BY_POLICY"
    }
}
