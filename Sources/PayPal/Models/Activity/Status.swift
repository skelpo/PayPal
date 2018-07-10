import Vapor

/// The transaction status of an `Activity` object.
public enum ActivityStatus: String, Hashable, CaseIterable, Content {
    
    /// A non-allowed activity. The payment violates regulations or compliance rules.
    case blocked = "BLOCKED"
    
    /// An initiator-canceled transaction.
    case canceled = "CANCELED"
    
    /// A successful transaction.
    case completed = "COMPLETED"
    
    /// A successfully created transaction.
    case created = "CREATED"
    
    /// A sender-initiated payment that a recipient denies.
    ///
    /// - Note: PayPal credits the funds to the sender’s account.
    case denied = "DENIED"
    
    /// A failed transaction.
    case failed = "FAILED"
    
    /// A temporarily-held transaction.
    ///
    /// - NOTE: Because a sender disputes or PayPal reviews the transaction, it is temporarily held.
    case held = "HELD"
    
    /// A paid invoice or money request.
    case paid = "PAID"
    
    /// A partially-paid transaction.
    case partiallyPaid = "PARTIALLY_PAID"
    
    /// A partially-refunded transaction.
    case partiallyRefunded = "PARTIALLY_REFUNDED"
    
    /// An in-process payment.
    case pending = "PENDING"
    
    /// A merchant-initiated refund to a customer.
    case refunded = "REFUNDED"
    
    /// A PayPal-canceled transaction.
    case reversed = "REVERSED"
    
    /// An unclaimed payment. A recipient did not accept or receive a sender’s payment.
    ///
    /// - Note: PayPal automatically cancels unclaimed transactions after 30 days and credits the funds to the sender’s account.
    case unclaimed = "UNCLAIMED"
}
