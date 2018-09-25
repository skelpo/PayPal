import Vapor

extension RelatedResource {
    public struct Authorization {}
}

extension RelatedResource.Authorization {
    
    /// The payment mode of an authorization. 
    public enum PaymentMode: String, Hashable, CaseIterable, Content {
        
        /// Instant transfer.
        ///
        /// `INSTANT_TRANSFER`.
        case instant = "INSTANT_TRANSFER"
    }
}

extension RelatedResource.Authorization {
    
    /// The authorized payment state.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// The authorized payment is pending.
        case pending
        
        /// The authorized payment is authorized.
        case authorized
        
        /// The authorized payment is partially captured.
        case partiallyCaptured = "partially_captured"
        
        /// The authorized payment is captured.
        case captured
        
        /// The authorized payment is expired.
        case expired
        
        /// The authorized payment is voided.
        case voided
    }
}
