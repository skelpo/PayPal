import Vapor

extension TransactionInfo {
    
    /// The status of a transaction, used in `TransactionInfo`.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The transaction processing is complete.
        case completed = "COMPLETED"
        
        /// he items in the transaction are unclaimed. If they are not claimed within 30 days,
        /// the funds are returned to the sender.
        case unclaimed = "UNCLAIMED"
        
        /// The transaction was denied.
        case denied = "DENIED"
        
        /// The transaction failed.
        case failed = "FAILED"
        
        /// The transaction is on hold.
        case held = "HELD"
        
        /// The transaction is waiting to be processed.
        case pending = "PENDING"
        
        /// Payment for the transaction was partially refunded.
        case partiallyRefunded = "PARTIALLY_REFUNDED"
        
        /// Payment for the transaction was successfully refunded.
        case refunded = "REFUNDED"
        
        /// Payment for the transaction was reversed due to a chargeback or other type of reversal.
        case reversed = "REVERSED"
    }
}
