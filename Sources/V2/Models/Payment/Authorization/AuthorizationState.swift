extension Authorization {
    
    /// The possible statuses for an authorized payment.
    public enum Status: String, Hashable, Codable, CaseIterable {
        /// The authorized payment is created. No captured payments have been made for this authorized payment.
        case created = "CREATED"
        
        /// The authorized payment has one or more captures against it.
        /// The sum of these captured payments is greater than the amount of the original authorized payment.
        case captured = "CAPTURED"
        
        /// PayPal cannot authorize funds for this authorized payment.
        case denied = "DENIED"
        
        /// The authorized payment has expired.
        case expired = "EXPIRED"
        
        /// A captured payment was made for the authorized payment for an amount that is less
        /// than the amount of the original authorized payment.
        case partiallyCaptured = "PARTIALLY_CAPTURED"
        
        /// The authorized payment was voided. No more captured payments can be made against this authorized payment.
        case voided = "VOIDED"
        
    }
}
