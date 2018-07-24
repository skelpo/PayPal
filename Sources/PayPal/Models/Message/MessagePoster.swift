import Vapor

extension Message {
    
    /// Indicates which party of an operation posted the message.
    public enum Poster: String, Hashable, CaseIterable, Content {
        
        /// The customer posted the message.
        case buyer = "BUYER"
        
        /// The merchant posted the message.
        case seller = "SELLER"
    }
}
