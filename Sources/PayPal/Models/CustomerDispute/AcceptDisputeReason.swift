import Vapor

extension AcceptDisputeBody {
    
    /// The merchant's reason for acceptance of a customer's claim.
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// Merchant is accepting customer's claim as they could not ship the item back to the customer.
        case notShipped = "DID_NOT_SHIP_ITEM"
        
        /// Merchant is accepting customer's claim as it is taking too long for merchant to fulfil the order.
        case timeout = "TOO_TIME_CONSUMING"
        
        /// Merchant is accepting customer's claim as the item is lost in mail or transit.
        case lost = "LOST_IN_MAIL"
        
        /// Merchant is accepting customer's claim as the merchant is
        /// not able to find sufficient evidence to win this dispute.
        case insufficentEvidance = "NOT_ABLE_TO_WIN"
        
        /// Merchant is accepting customer’s claims to follow their internal company policy.
        case policy = "COMPANY_POLICY"
        
        /// This is the default value merchant can use if none of the above reasons apply.
        case none = "REASON_NOT_SET"
    }
}
