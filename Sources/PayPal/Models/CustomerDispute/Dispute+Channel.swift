import Vapor

extension CustomerDispute {
    
    /// The channel where the customer dispute was created.
    public enum Channel: String, Hashable, CaseIterable, Content {
        
        /// Dispute was created through PayPal.
        case `internal` = "INTERNAL"
        
        /// Dispute was created through an external channel, such as the customer's bank.
        case external = "EXTERNAL"
    }
}
