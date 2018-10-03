import Vapor

extension Address {
    
    /// Address normalization status for order payments by users in Brazil.
    public enum Normalization: String, Hashable, CaseIterable, Content {
        
        /// Unknown.
        case unknown = "UNKNOWN"
        
        /// Unnormalized user preferred.
        case unnormalizedUserPrefered = "UNNORMALIZED_USER_PREFERRED"
        
        /// Normalized
        case normalized = "NORMALIZED"
        
        /// Unnormalized
        case unnormalized = "UNNORMALIZED"
    }
}
