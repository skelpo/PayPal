import Vapor

extension RelatedResource {
    
    /// An authorization that is related to a payment's transaction.
    public struct Authorization: Content, Equatable {
        
        /// The ID of the authorization.
        public let id: String?
        
        /// The payment mode of the authorization.
        public let mode: PaymentMode?
        
        /// The authorized payment state.
        public let state: State?
        
        /// The reason code for the pending transaction state.
        public let reason: Reason?
        
        /// The level of seller protection present for the transaction. Supported for the PayPal payment method only.
        public let protection: Protection?
        
        /// The type of seller protection for the transaction. Returned only when the `protection_eligibility`
        /// property is `ELIGIBLE` or `PARTIALLY_ELIGIBLE`. Supported for the PayPal payment method only
        public let protectionType: ProtectionType?
        
        /// The ID of the payment on which this transaction is based.
        public let payment: String?
        
        /// The date and time when the authorization expires, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let expiration: String?
        
        /// The date and time when the authorization was created, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let created: String?
        
        /// The date and time when the authorization was last updated,
        /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let updated: String?
        
        /// The receipt ID, which identifies the payment. Value is 16-digit numeric payment ID number that is returned for guest users.
        ///
        /// Pattern: `^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}$`.
        public let receipt: String?
        
        /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
        public let links: [LinkDescription]?
        
        
        /// The amount being authorized.
        public var amount: DetailedAmount
        
        /// The Fraud Management Filter (FMF) details that are applied to the payment that result in an accept, deny, or pending action.
        /// Returned in a payment response only if the merchant has enabled FMF in the profile settings and one of the fraud filters was
        /// triggered based on those settings. For more information, see
        /// [Fraud Management Filters Summary](https://developer.paypal.com/docs/classic/fmf/integration-guide/FMFSummary/).
        public var fmf: FraudManagementFilter?
        
        /// The processor-provided response codes that describe the submitted payment. Supported only when the `payment_method` is `credit_card`.
        public var processor: ProcessorResponse?
        
        
        /// Creates a new `RelatedResource.Authorization` instance.
        ///
        /// - Parameters:
        ///   - amount: The amount being authorized.
        ///   - fmf: The Fraud Management Filter (FMF) details that are applied to the payment that result in an accept, deny, or pending action.
        ///   - processor: The processor-provided response codes that describe the submitted payment.
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
        
        enum CodingKeys: String, CodingKey {
            case id, amount, state, links
            case mode = "payment_mode"
            case reason = "reason_code"
            case protection = "protection_eligibility"
            case protectionType = "protection_eligibility_type"
            case fmf = "fmf_details"
            case payment = "parent_payment"
            case processor = "processor_response"
            case expiration = "valid_until"
            case created = "create_time"
            case updated = "update_time"
            case receipt = "receipt_id"
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
