import Vapor

public struct Refund {}

extension Refund {
    
    /// The status of a refund instance.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The refund is pending.
        case pending = "PENDING"
        
        /// The refund completed.
        case complete = "COMPLETE"
        
        /// The refund failed.
        case failed = "FAILED"
    }
}
