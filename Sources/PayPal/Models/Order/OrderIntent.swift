import Vapor

extension Order {
    
    /// Possible intents for an order. This can either be `SALE` or `AUTHORIZE`.
    public enum Intent: String, Hashable, CaseIterable, Content {
        
        /// A sale.
        case sale = "SALE"
        
        /// An authorization.
        case authorize = "AUTHORIZE"
    }
}
