import Vapor

extension PaymentDetail {
    
    /// The payment types for an invoicing flow.
    public enum DetailType: String, Hashable, CaseIterable, Content {
        
        /// `PAYPAL`
        case paypal = "PAYPAL"
        
        /// `EXTERNAL`
        case external = "EXTERNAL"
    }
}
