import Vapor

public struct Capture {}

extension Capture {
    
    /// The statuses of a capture transaction.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The purchase unit status is `CAPTURED` and the capture status is pending.
        case pending = "PENDING"
        
        /// The purchase unit status is `CAPTURED` and the payment was captured successfully.
        case complete = "COMPLETE"
        
        /// The purchase unit status is `CAPTURED` and the dispute decision was in the customer's favor.
        /// A full refund for the captured payment was made successfully to the customer.
        case refunded = "REFUNDED"
        
        /// The purchase unit status is `CAPTURED` and the dispute decision was in the customer's favor.
        /// A partial refund for the captured payment was made successfully to the customer.
        case partiallyRefunded = "PARTIALLY_REFUNDED"
        
        /// The purchase unit status is `CAPTURED` and the capture was denied.
        case denied = "DENIED"
    }
}

extension Capture {
    
    /// A reason code that indicates the reason for a transaction state of `PENDING` or `REVERSED`.
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// The transaction state is `PENDING` or `REVERSED` due to a chargeback.
        case chargeback = "CHARGEBACK"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a guarantee.
        case guarantee = "GUARANTEE"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a buyer complaint.
        case buyerComplaint = "BUYER_COMPLAINT"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a refund.
        case refund = "REFUND"
        
        /// The transaction state is `PENDING` or `REVERSED` due to an unconfirmed shipping address.
        case unconfirmedAddress = "UNCONFIRMED_SHIPPING_ADDRESS"
        
        /// The transaction state is `PENDING` or `REVERSED` due to an e-check.
        case echeck = "ECHECK"
        
        /// The transaction state is `PENDING` or `REVERSED` due to an international withdrawal.
        case internationalWithdrawal = "INTERNATIONAL_WITHDRAWAL"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a receiving preference that mandates manual action.
        case manualAction = "RECEIVING_PREFERENCE_MANDATES_MANUAL_ACTION"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a payment review.
        case review = "PAYMENT_REVIEW"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a regulatory review.
        case regulatory = "REGULATORY_REVIEW"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a unilateral reason.
        case unilateral = "UNILATERAL"
        
        /// The transaction state is `PENDING` or `REVERSED` because verification is required.
        case verification = "VERIFICATION_REQUIRED"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a delayed disbursement.
        case disbursement = "DELAYED_DISBURSEMENT"
    }
}
