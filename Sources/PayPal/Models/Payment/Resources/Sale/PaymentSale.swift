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
