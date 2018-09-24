import Vapor

extension RelatedResource {
    public struct Sale {}
}

extension RelatedResource.Sale {
    
    /// The possible transaction payment modes.
    public enum PaymentMode: String, Hashable, CaseIterable, Content {
        
        /// `INSTANT_TRANSFER`.
        case instantTransfer = "INSTANT_TRANSFER"
        
        /// `MANUAL_BANK_TRANSFER`.
        case manualTransfer = "MANUAL_BANK_TRANSFER"
        
        /// `DELAYED_TRANSFER`.
        case delayedTransfer = "DELAYED_TRANSFER"
        
        /// `ECHECK`.
        case echeck = "ECHECK"
    }
}

extension RelatedResource.Sale {
    
    /// The state of a sale transaction.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// `completed`.
        case completed
        
        /// `partially_refunded`.
        case partiallyRefunded = "partially_refunded"
        
        /// `pending`.
        case pending
        
        /// `refunded`.
        case refunded
        
        /// `denied`.
        case denied
    }
}
