import Vapor

extension BillingPlan {
    
    /// The type of a `BillingPlan` object, defining whether the plan has a fixed
    /// time period or continues indeffinately.
    public enum PlanType: String, Hashable, CaseIterable, Content {
        
        /// The parent plan continues for a fixed amount of time.
        case fixed = "FIXED"
        
        /// The parent plan continues for an indefinate amount of time.
        case infinite = "INFINITE"
    }
}
