import Vapor

/// Occasionally, something goes wrong with a customer's order. To dispute a charge, a customer can create a dispute with PayPal.
/// PayPal merchants, partners, and external developers can use the PayPal Customer Disputes API to manage customer disputes.
///
/// - Note: Merchants cannot create disputes but can only respond to customer-created disputes.
///
/// A customer can also ask his or her bank or credit card company to dispute and reverse a charge, which is known as a chargeback. For more information,
/// see [Disputes, claims, chargebacks, and bank reversals](https://www.paypal.com/us/brc/article/customer-disputes-claims-chargebacks-bank-reversals).
///
/// When a customer disputes a charge, you can use this API to provide evidence that the charge is legitimate. To provide evidence or
/// appeal a dispute, you submit a proof of delivery or proof of refund document or notes, which can include logs.
///
/// Normally, an agent at PayPal updates the status of disputes and settles them, but now you can run test cases in the sandbox that complete these operations.
///
/// For details, see [Customer Disputes Integration Guide](https://developer.paypal.com/docs/integration/direct/customer-disputes/)
/// and the [Marketplace Disputes Integration Guide](https://developer.paypal.com/docs/marketplaces/how-to/manage-disputes/).
///
///
/// Use the `/customer/disputes/` resource to list disputes, show dispute details, send a message to the other party, make an offer to resolve a dispute,
/// escalate a dispute to a claim, provide evidence, accept a claim, and appeal a dispute. Normally, an agent at PayPal updates the status of disputes and
/// settles them, but now you can run test cases in the sandbox that update the dispute status and settle disputes.
public final class CustomerDisputes: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"customer/disputes"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public init(container: Container) {
        self.container = container
        self.resource = "customer/disputes"
    }
}
