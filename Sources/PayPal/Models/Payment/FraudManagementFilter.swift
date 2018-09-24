import Vapor

public struct FraudManagementFilter {}

extension FraudManagementFilter {
    
    /// The filter type of the Fraud Management Filter.
    public enum FilterType: String, Hashable, CaseIterable, Content {
        
        /// The accept filter type.
        case accept = "ACCEPT"
        
        /// The pending filter type.
        case pending = "PENDING"
        
        /// The deny filter type.
        case deny = "DENY"
        
        /// The report filter type.
        case report = "REPORT"
    }
}
