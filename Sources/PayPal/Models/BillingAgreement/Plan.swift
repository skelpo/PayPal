import Vapor

/// A payment plan for a billing agreement.
public struct Plan: Content, Equatable {
    
    /// The PayPal-generated ID for the resource.
    ///
    /// Maximum length: 128.
    public let id: String?
    
    /// The plan name.
    ///
    /// Maximum length: 128.
    public var name: String
    
    /// The plan description.
    ///
    /// Maximum length: 128.
    public var description: String
    
    /// The plan type.
    public var type: PlanType
    
    /// The status of the plan.
    public let state: PlanState?
    
    /// The date and time when the plan was created.
    public let created: Date?
    
    /// The date and time when this plan was last updated
    public let updated: Date?
    
    /// An array of payment definitions for this plan.
    public var paymentDefinitions: [Payment]?
    
    /// An array of terms for this plan.
    public let terms: [Term]?
    
    /// The merchant preferences that override the default information in the plan.
    /// If you omit this parameter, the agreement uses the default merchant preferences from the plan.
    /// The merchant preferences include how much it costs to set up the agreement, the URLs where the
    /// customer can approve or cancel the agreement, the maximum number of allowed failed payment attempts,
    /// whether PayPal automatically bills the outstanding balance in the next billing cycle,
    /// and the action if the customer's initial payment fails.
    public var preferances: MerchantPreferances?
    
    /// The currency code for the plan.
    public let currency: Currency?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// Creates a new `Plan` instance.
    ///
    ///     Plan(
    ///         name: "Monthly Water",
    ///         description: "Your water payment",
    ///         type: .infinate,
    ///         payments: [
    ///             Payment(
    ///                 name: "Water Charge",
    ///                 type: .regular,
    ///                 interval: "1",
    ///                 frequency: .month,
    ///                 cycles: "0",
    ///                 amount: Money(currency: .usd, value: "10.00"),
    ///                 charges: nil
    ///             )
    ///         ],
    ///         preferances: nil
    ///     )
    public init(name: String, description: String, type: PlanType, payments: [Payment]?, preferances: MerchantPreferances?) {
        self.id = nil
        self.state = nil
        self.created = nil
        self.updated = nil
        self.terms = nil
        self.currency = nil
        self.links = nil
        
        self.name = name
        self.description = description
        self.type = type
        self.paymentDefinitions = payments
        self.preferances = preferances
    }
}
