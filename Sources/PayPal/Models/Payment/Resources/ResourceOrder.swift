import Vapor

extension RelatedResource {
    public struct Order {}
}

extension RelatedResource.Order {
    
    /// A transaction's payment mode.
    public enum PaymentMode: String, Hashable, CaseIterable, Content {
        
        /// `INSTANT_TRANSFER`
        case instant = "INSTANT_TRANSFER"
        
        /// `MANUAL_BANK_TRANSFER`
        case manual = "MANUAL_BANK_TRANSFER"
        
        /// `DELAYED_TRANSFER`
        case delayed = "DELAYED_TRANSFER"
        
        /// `ECHECK`
        case echeck = "ECHECK"
    }
}
