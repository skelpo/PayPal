import Vapor

/// The type of additional charge that was added to a payment.
public enum ChargeType: String, Hashable, CaseIterable, Content {
    
    ///
    case tax = "TAX"
    
    ///
    case shipping = "SHIPPING"
}
