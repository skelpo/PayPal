import PayPal
import NIO

/// Call the Payments API to authorize payments, capture authorized payments, refund payments that have already been captured,
/// and show payment information. Use the Payments API in conjunction with the
/// [Orders API](https://developer.paypal.com/docs/api/orders/v2/). For more information,
/// see the [PayPal Checkout Overview](https://developer.paypal.com/docs/checkout/).
///
/// # Authorizations
///
/// Use the `/authorizations` resource to show details for, capture payment for, reauthorize, and void authorized payments.
///
/// # Captures
///
/// Use the `/captures` resource to show details for and refund a captured payment.
///
/// # Refunds
///
/// Use the `/refunds` resource to show refund details.
public final class Payments: VersionedController {
    
    /// See `VersionedController.client`
    public let client: PayPalClient
    
    /// See `VersionedController.resource`.
    public let resource: [String]
    
    /// See `VersionedController.init(client:)`.
    public init(client: PayPalClient) {
        self.client = client
        self.resource = ["payments"]
    }
    
    /// The controller for the `/payments/authorizations` resource.
    public var authorizations: Authorizations {
        return Authorizations(client: self.client)
    }
    
    /// The controller for the `/payments/captures` resource.
    public var captures: Captures {
        return Captures(client: self.client)
    }
    
    /// The controller for the `/payments/refunds` resource.
    public var refunds: Refunds {
        return Refunds(client: self.client)
    }
}
