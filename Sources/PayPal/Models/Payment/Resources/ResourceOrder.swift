import Vapor

extension RelatedResource {
    
    /// The details of an order transaction.
    public struct Order: Content, Equatable {
        
        /// The ID of the order transaction.
        public let id: String?
        
        /// The transaction payment mode.
        public let mode: PaymentMode?
        
        /// The state of the order transaction.
        public let state: State?
        
        /// The reason code that describes why the transaction state is pending or reversed.
        /// Eventually, this parameter will replace the `pending_reason` parameter. Supported only for PayPal payments.
        public let reason: Reason?
        
        /// The level of seller protection in effect for the transaction.
        public let protection: Protection?
        
        /// The kind of seller protection in effect for the transaction. Returned only when the `protection_eligibility`
        /// property is `ELIGIBLE` or `PARTIALLY_ELIGIBLE`. Supported only for PayPal payments.
        public let protectionType: ProtectionType?
        
        /// The ID of the payment on which this transaction is based.
        public let parent: String?
        
        /// The date and time when the resource was created, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let created: ISO8601Date?
        
        /// The date and time when the resource was last updated, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let updated: ISO8601Date?
        
        /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
        public let links: [LinkDescription]?
        
        
        /// The amount to collect.
        ///
        /// - Note: For an order authorization, you cannot include amount details.
        public var amount: DetailedAmount
        
        /// The Fraud Management Filter (FMF) details that are applied to the payment that result in an accept, deny, or pending action.
        /// Returned in a payment response only if the merchant has enabled FMF in the profile settings and one of the fraud filters was
        /// triggered based on those settings. For more information, see
        /// [Fraud Management Filters Summary](https://developer.paypal.com/docs/classic/fmf/integration-guide/FMFSummary/).
        public var fmf: FraudManagementFilter?
        
        
        /// Creates a new `RelatedResource.Order` instance.
        ///
        /// - Parameters:
        ///   - amount: The amount to collect.
        ///   - fmf: The Fraud Management Filter (FMF) details that are applied to the payment that result in an accept, deny, or pending action.
        public init(amount: DetailedAmount, fmf: FraudManagementFilter?) {
            self.id = nil
            self.mode = nil
            self.state = nil
            self.reason = nil
            self.protection = nil
            self.protectionType = nil
            self.parent = nil
            self.created = nil
            self.updated = nil
            self.links = nil
            
            self.amount = amount
            self.fmf = fmf
        }
        
        enum CodingKeys: String, CodingKey {
            case id, state, links, amount
            case mode = "payment_mode"
            case reason = "reason_code"
            case protection = "protection_eligibility"
            case protectionType = "protection_eligibility_type"
            case parent = "parent_payment"
            case created = "create_time"
            case updated = "update_time"
            case fmf = "fmf_details"
        }
    }
}

extension RelatedResource.Order {
    
    /// A transaction's payment mode.
    public enum PaymentMode: String, Hashable, CaseIterable, Content {
        
        /// `INSTANT_TRANSFER`
        case instant = "INSTANT_TRANSFER"
        
        /// `MANUAL_BANK_TRANSFER`
        case manual = "MANUAL_BANK_TRANSFER"
        
        /// `DELAYED_TRANSFER`
        case delayed = "DELAYED_TRANSFER"
        
        /// `ECHECK`
        case echeck = "ECHECK"
    }
}

extension RelatedResource.Order {
    
    /// The state of an order transaction
    public enum State: String, Hashable, CaseIterable, Content {
        
        ///  The order was created but no authorizations or captures were made against the order.
        case pending
        
        ///  The order has only been authorized. No capture was made against the order.
        case authorized
        
        ///  The order has at least one capture initiated.
        case captured
        
        ///  The order is complete. A capture was made against the order with `is_final_capture` set to `TRUE`.
        /// No more authorizations or captures can be made against this order.
        case completed
        
        ///  The order was voided. No more authorizations or captures can be made against this order. captures case can be made against this order.
        case voided
    }
}

extension RelatedResource.Order {
    
    /// The reason code that describes why a transaction state is pending or reversed.
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// `PAYER_SHIPPING_UNCONFIRMED`.
        case shippingUnconfirmed = "PAYER_SHIPPING_UNCONFIRMED"
        
        /// `MULTI_CURRENCY`.
        case multiCurrency = "MULTI_CURRENCY"
        
        /// `RISK_REVIEW`.
        case risk = "RISK_REVIEW"
        
        /// `REGULATORY_REVIEW`.
        case regulatory = "REGULATORY_REVIEW"
        
        /// `VERIFICATION_REQUIRED`.
        case verification = "VERIFICATION_REQUIRED"
        
        /// `ORDER`.
        case order = "ORDER"
        
        /// `OTHER`.
        case other = "OTHER"
    }
}
