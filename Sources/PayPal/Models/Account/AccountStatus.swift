import Vapor

/// The statuses availible to an account.
public enum AccountStatus: String, Hashable, CaseIterable, Content {
    
    /// `A`.
    case a = "A"
    
    /// `PV`.
    case pv = "PV"
    
    /// `PUA`.
    case pua = "PUA"
}
