import Vapor

extension CustomerDispute.Outcome {
    
    /// The outcome of a resolved dispute.
    public enum Code: String, Hashable, CaseIterable, Content {
        
        /// The dispute was resolved in the customer's favor.
        case buyer = "RESOLVED_BUYER_FAVOUR"
        
        /// The dispute was resolved in the merchant's favor.
        case seller = "RESOLVED_SELLER_FAVOUR"
        
        /// PayPal provided the merchant or customer with protection and the case is resolved.
        case resolved = "RESOLVED_WITH_PAYOUT"
        
        /// The customer canceled the dispute.
        case cancelled = "CANCELED_BY_BUYER"
        
        /// The dispute was accepted by PayPal.
        case accepted = "ACCEPTED"
        
        /// The dispute was denied by PayPal.
        case denied = "DENIED"
    }
}
