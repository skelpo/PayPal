import Vapor

extension RelatedResource {
    public struct Sale: Content, Equatable {
        public let id: String
        public let purchaseID: String?
        public let mode: PaymentMode?
        public let state: State
        public let reason: Reason?
        public let protection: Protection?
        public let protectionType: ProtectionType?
        public let clearing: String?
        public let holdStatus: String?
        public let holdReason: Payment.HoldReason?
        public let receipt: String?
        public let parent: String
        public let billingAgreement: String?
        public let created: String
        public let updated: String?
        public let links: [LinkDescription]?
        
        public var amount: DetailedAmount
        public var transaction: Amount?
        public var receivable: Amount?
        public var exchangeRate: String?
        public var fmf: FraudManagementFilter?
        public var processor: ProcessorResponse?
        
        public init(
            id: String,
            amount: DetailedAmount,
            state: State,
            transaction: Amount? = nil,
            receivable: Amount? = nil,
            exchangeRate: String? = nil,
            fmf: FraudManagementFilter? = nil,
            processor: ProcessorResponse? = nil,
            parent: String,
            created: String = Date().iso8601
        ) {
            self.id = id
            self.purchaseID = nil
            self.mode = nil
            self.state = state
            self.reason = nil
            self.protection = nil
            self.protectionType = nil
            self.clearing = nil
            self.holdStatus = nil
            self.holdReason = nil
            self.receipt = nil
            self.parent = parent
            self.billingAgreement = nil
            self.created = created
            self.updated = nil
            self.links = nil
            self.amount = amount
            self.transaction = transaction
            self.receivable = receivable
            self.exchangeRate = exchangeRate
            self.fmf = fmf
            self.processor = processor
        }
    }
}

extension RelatedResource.Sale {
    
    /// The possible transaction payment modes.
    public enum PaymentMode: String, Hashable, CaseIterable, Content {
        
        /// `INSTANT_TRANSFER`.
        case instantTransfer = "INSTANT_TRANSFER"
        
        /// `MANUAL_BANK_TRANSFER`.
        case manualTransfer = "MANUAL_BANK_TRANSFER"
        
        /// `DELAYED_TRANSFER`.
        case delayedTransfer = "DELAYED_TRANSFER"
        
        /// `ECHECK`.
        case echeck = "ECHECK"
    }
}

extension RelatedResource.Sale {
    
    /// The state of a sale transaction.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// `completed`.
        case completed
        
        /// `partially_refunded`.
        case partiallyRefunded = "partially_refunded"
        
        /// `pending`.
        case pending
        
        /// `refunded`.
        case refunded
        
        /// `denied`.
        case denied
    }
}

extension RelatedResource.Sale {
    
    /// A reason code that describes why the transaction state is pending or reversed.
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// `CHARGEBACK`.
        case chargeback = "CHARGEBACK"
        
        /// `GUARANTEE`.
        case guarantee = "GUARANTEE"
        
        /// `BUYER_COMPLAINT`.
        case complaint = "BUYER_COMPLAINT"
        
        /// `REFUND`.
        case refund = "REFUND"
        
        /// `UNCONFIRMED_SHIPPING_ADDRESS`.
        case unconfirmedAddress = "UNCONFIRMED_SHIPPING_ADDRESS"
        
        /// `ECHECK`.
        case echeck = "ECHECK"
        
        /// `INTERNATIONAL_WITHDRAWAL`.
        case withdrawl = "INTERNATIONAL_WITHDRAWAL"
        
        /// `RECEIVING_PREFERENCE_MANDATES_MANUAL_ACTION`.
        case manualAction = "RECEIVING_PREFERENCE_MANDATES_MANUAL_ACTION"
        
        /// `PAYMENT_REVIEW`.
        case payment = "PAYMENT_REVIEW"
        
        /// `REGULATORY_REVIEW`.
        case regulatory = "REGULATORY_REVIEW"
        
        /// `UNILATERAL`.
        case unilateral = "UNILATERAL"
        
        /// `VERIFICATION_REQUIRED`.
        case verification = "VERIFICATION_REQUIRED"
        
        /// `TRANSACTION_APPROVED_AWAITING_FUNDING`.
        case awaitingFunding = "TRANSACTION_APPROVED_AWAITING_FUNDING"
    }
}

extension RelatedResource.Sale {
    
    /// The merchant protection level in effect for a transaction.
    public enum Protection: String, Hashable, CaseIterable, Content {
        
        /// `ELIGIBLE`.
        case eligible = "ELIGIBLE"
        
        /// `PARTIALLY_ELIGIBLE`.
        case partiallyEligible = "PARTIALLY_ELIGIBLE"
        
        /// `INELIGIBLE`.
        case ineligible = "INELIGIBLE"
    }
}

extension RelatedResource.Sale {
    
    /// The merchant protection type in effect for a transaction.
    public enum ProtectionType: String, Hashable, CaseIterable, Content {
        
        /// `ITEM_NOT_RECEIVED_ELIGIBLE`.
        case itemNotReceived = "ITEM_NOT_RECEIVED_ELIGIBLE"
        
        /// `UNAUTHORIZED_PAYMENT_ELIGIBLE`.
        case unauthorizedPayment = "UNAUTHORIZED_PAYMENT_ELIGIBLE"
    }
}
