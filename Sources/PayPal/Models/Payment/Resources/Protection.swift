import Vapor

extension RelatedResource {
    
    /// The merchant protection level in effect for a transaction.
    public enum Protection: String, Hashable, CaseIterable, Content {
        
        /// `ELIGIBLE`.
        case eligible = "ELIGIBLE"
        
        /// `PARTIALLY_ELIGIBLE`.
        case partiallyEligible = "PARTIALLY_ELIGIBLE"
        
        /// `INELIGIBLE`.
        case ineligible = "INELIGIBLE"
    }
}

extension RelatedResource {
    
    /// The merchant protection type in effect for a transaction.
    public enum ProtectionType: String, Hashable, CaseIterable, Content {
        
        /// Sellers are protected against claims for items not received.
        ///
        /// `ITEM_NOT_RECEIVED_ELIGIBLE`.
        case itemNotReceived = "ITEM_NOT_RECEIVED_ELIGIBLE"
        
        /// Sellers are protected against claims for unauthorized payments.
        ///
        /// `UNAUTHORIZED_PAYMENT_ELIGIBLE`.
        case unauthorizedPayment = "UNAUTHORIZED_PAYMENT_ELIGIBLE"
        
        /// Sellers are protected against claims for items not received and sellers are protected against claims for unauthorized payments.
        ///
        /// `ITEM_NOT_RECEIVED_ELIGIBLE,UNAUTHORIZED_PAYMENT_ELIGIBLE`.
        case all = "ITEM_NOT_RECEIVED_ELIGIBLE,UNAUTHORIZED_PAYMENT_ELIGIBLE"
    }
}

