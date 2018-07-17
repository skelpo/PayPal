import Vapor

/// The current state of a billing agreement plan.
public enum PlanSate: String, Hashable, CaseIterable, Content {
    
    /// The plan has been created.
    case created = "CREATED"
    
    /// The plan is active.
    case active = "ACTIVE"
    
    /// The plan is inactive (paused).
    case inactive = "INACTIVE"
    
    /// The plan has been deleted.
    case deleted = "DELETED"
}
