import Vapor

extension Order {
    public struct Unit {}
}

extension Order.Unit {
    
    /// The transaction state of a purchase unit.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The transaction was not processed.
        case notProcessed = "NOT_PROCESSED"
        
        /// The transaction is pending.
        case pending = "PENDING"
        
        /// The transaction was declined and voided.
        case voided = "VOIDED"
        
        /// Payment for the transaction was not authorized.
        case authorized = "AUTHORIZED"
        
        /// Payment for the transaction was captured or is pending capture.
        case captured = "CAPTURED"
    }
}
