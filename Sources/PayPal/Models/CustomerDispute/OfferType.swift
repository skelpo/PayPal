import Vapor

extension Offer {
    
    /// The merchant-proposed offer type for the dispute.
    public enum OfferType: String, Hashable, CaseIterable, Content {
        
        /// The merchant must refund the customer without any item replacement or return.
        case refund = "REFUND"
        
        /// The customer must return the item to the merchant.
        case `return` = "REFUND_WITH_RETURN"
        
        /// The merchant must send a replacement item to the customer.
        case replacement = "REFUND_WITH_REPLACEMENT"
    }
}
