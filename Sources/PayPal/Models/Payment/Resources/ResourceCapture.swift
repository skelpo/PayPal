import Vapor

extension RelatedResource {
    public struct Capture {}
}

extension RelatedResource.Capture {
    
    /// The state of a capture
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// The capture is pending.
        case pending
        
        /// The capture has successfully completed.
        case completed
        
        /// The capture was fully refunded.
        case refunded
        
        /// The capture was partially refunded.
        case partiallyRefunded = "partially_refunded"
        
        /// PayPal has declined to process this transaction.
        case denied
    }
}

extension RelatedResource.Capture {}

extension RelatedResource.Capture {}
