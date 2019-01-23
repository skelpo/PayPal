import Vapor

/// A payment plan for a billing agreement.
public struct BillingPlan: Content, Equatable {
    
    /// The PayPal-generated ID for the resource.
    ///
    /// Maximum length: 128.
    public let id: Optional128String
    
    /// The plan name.
    ///
    /// Maximum length: 128.
    public var name: Failable<String, Length128>
    
    /// The plan description.
    ///
    /// Maximum length: 128.
    public var description: Failable<String, Length128>
    
    /// The plan type.
    ///
    /// - Warning: This property must have a value when used in the Billing Agreement API.
    public var type: PlanType?
    
    /// The status of the plan.
    public let state: State?
    
    /// The date and time when the plan was created.
    public let created: Date?
    
    /// The date and time when this plan was last updated
    public let updated: Date?
    
    /// An array of payment definitions for this plan.
    public var payments: [BillingPayment<CurrencyAmount>]?
    
    /// An array of terms for this plan.
    public let terms: [Term]?
    
    /// The merchant preferences that override the default information in the plan.
    /// If you omit this parameter, the agreement uses the default merchant preferences from the plan.
    /// The merchant preferences include how much it costs to set up the agreement, the URLs where the
    /// customer can approve or cancel the agreement, the maximum number of allowed failed payment attempts,
    /// whether PayPal automatically bills the outstanding balance in the next billing cycle,
    /// and the action if the customer's initial payment fails.
    public var preferances: MerchantPreferances<CurrencyAmount>?
    
    /// The currency code for the plan.
    public let currency: Currency?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// Creates a new `BillingPlan` instance.
    ///
    /// - Parameters:
    ///   - name: The plan name.
    ///   - description: The plan description.
    ///   - type: The plan type.
    ///   - payments: An array of payment definitions for this plan.
    ///   - preferances: The merchant preferences that override the default information in the plan.
    public init(
        name: Failable<String, Length128>,
        description: Failable<String, Length128>,
        type: BillingPlan.PlanType,
        payments: [BillingPayment<CurrencyAmount>]?,
        preferances: MerchantPreferances<CurrencyAmount>?
    )throws {
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
        self.payments = payments
        self.preferances = preferances
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, type, state, terms, links
        case created = "created_time"
        case updated = "updated_time"
        case payments = "payment_definitions"
        case preferances = "merchant_preferences"
        case currency = "currency_code"
    }
}
