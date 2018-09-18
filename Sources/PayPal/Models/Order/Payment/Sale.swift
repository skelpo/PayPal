import Vapor

public struct Sale {}

extension Sale {
    
    /// The status of a sale transaction.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The sale completed.
        case completed = "COMPLETED"
        
        /// The sale was partially refunded.
        case partiallyRefunded = "PARTIALLY_REFUNDED"
        
        /// The sale is pending.
        case pending = "PENDING"
        
        /// The sale was refunded.
        case refunded = "REFUNDED"
        
        /// The sale was denied.
        case denied = "DENIED"
    }
}
