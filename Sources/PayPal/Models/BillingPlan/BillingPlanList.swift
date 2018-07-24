import Vapor

/// The structure of the response object returned from the `GET /v1/payments/billing-plans`
/// endpoint, or the `BillingPlans.list(paramaters:)` method.
public struct BillingPlanList: Content, Equatable {
    
    /// The total number of plans in the list.
    public let items: String?
    
    /// The total number of pages in the response. The `page_size` request value determines
    /// how many plans appear on each page. The `total_items` and `page_size` request values
    /// are used to calculate the total number of pages in the response.
    public let pages: String?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    /// An array of plans.
    public var plans: [BillingPlan]?
    
    
    /// Creates a new `BillingPlanList` instance.
    ///
    /// You will most likley not need to use this iniializer;
    /// rather, use the `init(from:)` decoder init.
    public init(plans: [BillingPlan]) {
        self.pages = nil
        self.links = nil
        
        self.items = String(describing: plans.count)
        self.plans = plans
    }
}
