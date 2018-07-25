import Vapor

extension CustomerDispute {
    
    /// The status of a customer dispute.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// Open.
        case open = "OPEN"
        
        /// The dispute is waiting for a response from the customer.
        case waitingBuyer = "WAITING_FOR_BUYER_RESPONSE"
        
        /// The dispute is waiting for a response from the merchant.
        case waitingSeller = "WAITING_FOR_SELLER_RESPONSE"
        
        /// The dispute is under review with PayPal.
        case review = "UNDER_REVIEW"
        
        /// The dispute is resolved.
        case resolved = "RESOLVED"
        
        /// This is a default status if the dispute cannot be mapped to one of the other statuses.
        case other = "OTHER"
    }
}
