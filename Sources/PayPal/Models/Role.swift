import Vapor

/// The role of a user or merchant in a transaction.
public enum Role: String, Hashable, CaseIterable, Content {
    
    /// A user requested a payment in the transaction.
    case requester = "REQUESTER"
    
    /// A user was requested to make a payment in the transaction.
    case requestee = "REQUESTEE"
    
    /// A user made a payment in the transaction
    case payer = "PAYER"
    
    /// A user received a payment in the transaction.
    case payee = "PAYEE"
}
