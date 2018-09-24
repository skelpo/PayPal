import Vapor

extension RelatedResource {
    public struct Sale {}
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
