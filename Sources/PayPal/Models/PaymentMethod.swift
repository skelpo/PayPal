import Vapor

/// A payment method used for a transaction.
public enum PaymentMethod: String, Hashable, CaseIterable, Content {
    
    ///
    case bank
    
    ///
    case paypal
}
