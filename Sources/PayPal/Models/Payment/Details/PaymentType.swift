import Vapor

/// The developer who created this enum for the PayPal API didn't really document it,
/// so the developer who created this Swift client doesn't really know what to say about it.
/// Instead, you can have a unicorn: 🦄
public enum PaymentType: String, Hashable, CaseIterable, Content {
    
    ///
    case trial = "TRIAL"
    
    ///
    case regular = "REGULAR"
}
