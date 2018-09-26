import Vapor

extension RelatedResource {
    public struct Capture {}
}

extension RelatedResource.Capture {
    
    /// The state of a capture
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// The capture is pending.
        case pending
        
        /// The capture has successfully completed.
        case completed
        
        /// The capture was fully refunded.
        case refunded
        
        /// The capture was partially refunded.
        case partiallyRefunded = "partially_refunded"
        
        /// PayPal has declined to process this transaction.
        case denied
    }
}

extension RelatedResource.Capture {
    
    /// The reason code that describes why a transaction state is pending or reversed. 
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// The transaction state is `pending` or `reversed` due to a chargeback.
        case chargeback = "CHARGEBACK"
        
        /// The transaction state is `pending` or `reversed` due to a guarantee.case
        case guarantee = "GUARANTEE"
        
        /// The transaction state is `pending` or `reversed` due to a customer complaint.
        case buyerComplaint = "BUYER_COMPLAINT"
        
        /// The transaction state is `pending` or `reversed` due to a REFUND.
        case refund = "REFUND"
        
        /// The transaction state is `pending` or `reversed` due to an unconfirmed shipping address.
        case unconfirmedAddress = "UNCONFIRMED_SHIPPING_ADDRESS"
        
        /// The transaction state is `pending` or `reversed` due to an e-check.
        case echeck = "ECHECK"
        
        /// The transaction state is `pending` or `reversed` due to an international withdrawal.
        case withdrawl = "INTERNATIONAL_WITHDRAWAL"
        
        /// The transaction state is `pending` or `reversed` due to a receiving preference that mandates manual action.
        case manualAction = "RECEIVING_PREFERENCE_MANDATES_MANUAL_ACTION"
        
        /// The transaction state is `pending` or `reversed` due to a payment review.
        case payment = "PAYMENT_REVIEW"
        
        /// The transaction state is `pending` or `reversed` due to a regulatory review.
        case regulatory = "REGULATORY_REVIEW"
        
        /// The transaction state is `pending` or `reversed` due to a unilaterial action.
        case unilateral = "UNILATERAL"
        
        /// The transaction state is `pending` or `reversed` because verification is required.
        case verification = "VERIFICATION_REQUIRED"
        
        /// The transaction state is `pending` or `reversed` because an approved transaction is awaiting funding.
        case awaitingFunding = "TRANSACTION_APPROVED_AWAITING_FUNDING"
    }
}
