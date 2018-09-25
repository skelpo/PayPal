import Vapor

extension RelatedResource {
    public struct Authorization {
        public let id: String?
        public let mode: PaymentMode?
        public let state: State?
        public let reason: Reason?
        public let protection: Protection?
        public let protectionType: ProtectionType?
        public let payment: String?
        public let expiration: String?
        public let created: String?
        public let updated: String?
        public let receipt: String?
        public let links: [LinkDescription]?
        
        public var amount: DetailedAmount
        public var fmf: FraudManagementFilter?
        public var processor: ProcessorResponse?
        
        public init(amount: DetailedAmount, fmf: FraudManagementFilter?, processor: ProcessorResponse?) {
            self.id = nil
            self.mode = nil
            self.state = nil
            self.reason = nil
            self.protection = nil
            self.protectionType = nil
            self.payment = nil
            self.expiration = nil
            self.created = nil
            self.updated = nil
            self.receipt = nil
            self.links = nil
            
            self.amount = amount
            self.fmf = fmf
            self.processor = processor
        }
    }
}

extension RelatedResource.Authorization {
    
    /// The payment mode of an authorization.
    public enum PaymentMode: String, Hashable, CaseIterable, Content {
        
        /// Instant transfer.
        ///
        /// `INSTANT_TRANSFER`.
        case instant = "INSTANT_TRANSFER"
    }
}

extension RelatedResource.Authorization {
    
    /// The authorized payment state.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// The authorized payment is pending.
        case pending
        
        /// The authorized payment is authorized.
        case authorized
        
        /// The authorized payment is partially captured.
        case partiallyCaptured = "partially_captured"
        
        /// The authorized payment is captured.
        case captured
        
        /// The authorized payment is expired.
        case expired
        
        /// The authorized payment is voided.
        case voided
    }
}

extension RelatedResource.Authorization {
    
    /// The reason code for the pending transaction state.
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// `AUTHORIZATION`.
        case authorization = "AUTHORIZATION"
    }
}
