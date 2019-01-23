import Vapor

extension Product {
    
    /// The possible vetting statuses for partner products.
    public enum VettingStatus: String, Hashable, CaseIterable, Content {
        
        /// `APPROVED`
        case approved = "APPROVED"
        
        /// `PENDING`
        case pending = "PENDING"
        
        /// `DECLINED`
        case declined = "DECLINED"
    }
}
