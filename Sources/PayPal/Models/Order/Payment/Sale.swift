import Vapor

public struct Sale {
    public let id: String?
    public let status: Status?
    public let created: String?
    public let updated: String?
    public let links: [LinkDescription]?
    
    public var amount: DetailedAmount?
    public var transaction: Amount?
    
    public init(amount: DetailedAmount?, transaction: Amount?) {
        self.id = nil
        self.status = nil
        self.created = nil
        self.updated = nil
        self.links = nil
        
        self.amount = amount
        self.transaction = transaction
    }
}

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
