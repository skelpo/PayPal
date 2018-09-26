import Vapor

extension RelatedResource {
    public struct Order: Content, Equatable {
        public let id: String?
        public let mode: PaymentMode?
        public let state: State?
        public let reason: Reason?
        public let protection: Protection?
        public let protectionType: ProtectionType?
        public let parent: String?
        public let created: String?
        public let updated: String?
        public let links: [LinkDescription]?
        
        public var amount: DetailedAmount
        public var fmf: FraudManagementFilter?
        
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
