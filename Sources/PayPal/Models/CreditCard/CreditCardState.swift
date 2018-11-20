import Vapor

extension CreditCard {
    
    /// The credit card state that defines whether a card can still be used or has expired.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// The credit card number is still valid.
        case ok
        
        /// The specified credit card number has expired.
        case expired
    }
}
