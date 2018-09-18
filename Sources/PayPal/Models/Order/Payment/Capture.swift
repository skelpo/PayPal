import Vapor

/// A captures for a purchase unit.
public struct Capture: Content, Equatable {
    
    /// The ID of the capture transaction.
    public let id: String?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    /// The status of the capture transaction.
    public let status: Status?
    
    /// A reason code that indicates the reason for the transaction state of `PENDING` or `REVERSED`.
    public let reason: Reason?
    
    
    /// The amount to capture. Default is the authorization amount. If that amount is the same as the authorized amount,
    /// the authorization state changes to `CAPTURED`. Otherwise, the authorization state changes to `PARTIALLY_CAPTURED`.
    /// To indicate that this capture is the final capture, set `is_final_capture` to `true`.
    public var amount: DetailedAmount?
    
    /// The currency and amount of the transaction fee
    public var transaction: Amount?
    
    
    /// Creates a new `Capture` instance.
    ///
    /// - Parameters:
    ///   - amount: The amount to capture. Default is the authorization amount.
    ///   - transaction: The currency and amount of the transaction fee.
    public init(
        amount: DetailedAmount?,
        transaction: Amount?
    ) {
        self.id = nil
        self.links = nil
        self.status = nil
        self.reason = nil
        self.amount = amount
        self.transaction = transaction
    }
    
    enum CodingKeys: String, CodingKey {
        case id, links, status, amount
        case reason = "reason_code"
        case transaction = "transaction_fee"
    }
}

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
