import Vapor

extension RelatedResource {
    public struct Refund {}
}

extension RelatedResource.Refund {
    
    /// The state of a refund transaction. 
    public enum State: String, Hashable, CaseIterable, Content {
        
        ///  The refund state is pending.
        case pending
        
        ///  The refund state is completed.
        case completed
        
        ///  The refund state is cancelled.
        case cancelled
        
        ///  The refund state is failed.
        case failed
    }
}
