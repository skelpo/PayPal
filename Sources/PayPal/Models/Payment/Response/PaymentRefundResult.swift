import Vapor

extension Payment {
    public struct RefundResult {}
}

extension Payment.RefundResult {
    
    /// The state of a payment refund.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// `pending`.
        case pending
        
        /// `completed`.
        case completed
        
        /// `cancelled`.
        case cancelled
        
        /// `failed`.
        case failed
    }
}
