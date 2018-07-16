import Vapor

/// The billing period for a billing agreement plan.
public enum TermType: String, Hashable, CaseIterable, Content {
    
    /// Bills the customer weekly.
    case weekly = "WEEKLY"
    
    /// Bills the customer monthly.
    case monthly = "MONTHLY"
    
    /// Bills the customer yearly.
    case yearly = "YEARLY"
}

