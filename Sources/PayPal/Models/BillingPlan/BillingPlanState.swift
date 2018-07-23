import Vapor

extension BillingPlan {
    
    /// The current state of a billing agreement plan.
    public enum State: String, Hashable, CaseIterable, Content {
    
    /// The plan has been created.
    case created = "CREATED"
    
    /// The plan is active.
    case active = "ACTIVE"
    
    /// The plan is inactive (paused).
    case inactive = "INACTIVE"
    
    /// The plan has been deleted.
    ///
    /// - Warning: This case is not valid for the Billing Plan API.
    case deleted = "DELETED"
    }
}
