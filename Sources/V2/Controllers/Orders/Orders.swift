import PayPal
import Vapor

/// Use the Orders API to create, update, show details for, authorize and capture payments for, save, and void orders.
/// For more information, see the [PayPal Checkout Overview](https://developer.paypal.com/docs/checkout/).
///
/// # Orders
///
/// Use the `/orders` resource to create, update, show details for, and authorize and capture payments for orders.
public final class Orders: VersionedController {
    
    /// See `VersionedController.client`
    public let client: PayPalClient
    
    /// See `VersionedController.resource`.
    public let resource: [String]
    
    /// See `VersionedController.init(client:)`.
    public init(client: PayPalClient) {
        self.client = client
        self.resource = ["checkout", "orders"]
    }
}
