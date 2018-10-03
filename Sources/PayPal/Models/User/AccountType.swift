import Vapor

extension UserInfo {
    
    /// That type of account that a user has.
    public enum AccountType: String, Hashable, CaseIterable, Content {
        
        /// A personal account. `PERSONAL`
        case personal = "PERSONAL"
        
        /// A business account. `BUSINESS`
        case business = "BUSINESS"
        
        /// `PREMIER`
        case premier = "PREMIER"
    }
}
