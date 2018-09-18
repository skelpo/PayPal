import Vapor

public struct Refund {
    public let id: String?
    public let capture: String?
    public let sale: String?
    public let status: Status?
    public let links: [LinkDescription]?
    
    public let amount: DetailedAmount?
    
    public init(amount: DetailedAmount?) {
        self.id = nil
        self.capture = nil
        self.sale = nil
        self.status = nil
        self.links = nil
        self.amount = amount
    }
}

extension Refund {
    
    /// The status of a refund instance.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The refund is pending.
        case pending = "PENDING"
        
        /// The refund completed.
        case completed = "COMPLETED"
        
        /// The refund failed.
        case failed = "FAILED"
    }
}
