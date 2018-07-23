import Vapor

/// You use billing plans and billing agreements to create an agreement for a recurring PayPal or debit card payment for goods or services.
///
/// A billing plan includes payment definitions and other details. A plan must include at least one regular payment definition
/// and, optionally, a trial payment definition. Each definition determines how often and for how long a customer is charged.
///
/// A plan can specify a type, which indicates whether the payment definitions in the plan have a fixed or infinite number of payment cycles.
/// The plan also defines merchant preferences including how much it costs to set up the agreement, the links where a customer can approve
/// or can cancel the agreement, and the action if the customer's initial payment fails.
///
/// By default, a plan is not active when you create it. To activate it, you update its `state` to ACTIVE.
///
/// For more information, see [Billing Plans and Agreements](https://developer.paypal.com/docs/integration/direct/billing-plans-and-agreements/).
///
/// - Warning: The use of the PayPal REST `/payments` APIs to accept credit card payments is restricted.
///   Instead, you can accept credit card payments with [Braintree Direct](https://www.braintreepayments.com/products/braintree-direct).
public class BillingPlans: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"payments/billing-plans"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public required init(container: Container) {
        self.container = container
        self.resource = "payments/billing-plans"
    }
}
