import Vapor

extension AccountRelation {
    
    /// A type of account relationship.
    public enum RelationType: String, Hashable, CaseIterable, Content {
        
        /// `PARTNER`.
        case partner = "PARTNER"
        
        /// `SAME_MERCHANT`.
        case same = "SAME_MERCHANT"
    }
}
