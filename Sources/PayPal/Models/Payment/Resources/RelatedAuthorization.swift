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
