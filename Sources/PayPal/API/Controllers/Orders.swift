import Vapor

/// Use the Orders API to create, show details for, authorize, and capture payment for orders.
///
/// - Note: PayPal for Marketplaces is a limited-release solution aimed at marketplaces, crowd funding,
///   and multi-party commerce platforms. To use Orders API for Marketplaces, see
///   [Make an Orders API call](https://developer.paypal.com/docs/marketplaces/integrate/connected/progressive/#make-an-orders-api-call).
public final class Orders: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"checkout/orders"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public init(container: Container) {
        self.container = container
        self.resource = "checkout/orders"
    }
}

