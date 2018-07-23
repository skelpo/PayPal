import Vapor

extension Transaction {
    
    /// The current status of a billing agreement transaction.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// The transaction is complete and the money has been transferred to the payee.
        case completed = "Completed"
        
        /// A part of the transaction amount has been refunded to the payer.
        case partiallyRefunded = "Partially_Refunded"
        
        /// The transaction is pending settlement.
        case pending = "Pending"
        
        /// The transaction amount has been refunded to the payer.
        case refunded = "Refunded"
        
        /// The transaction has been denied.
        case denied = "Denied"
    }
}
