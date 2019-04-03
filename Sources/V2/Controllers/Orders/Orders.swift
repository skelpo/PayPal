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
    
    /// Creates an order. Supports orders with only one purchase unit.
    ///
    /// A successful request returns the HTTP 201 Created status code and a JSON response body that includes by default a
    /// minimal response with the ID, status, and HATEOAS links. If you require the complete order resource representation,
    /// you must pass the `.representation` value to the `prefer` parameter. This header value is not the default.
    ///
    /// - Parameters:
    ///   - order: The request body. This information is used to create an `Order` object.
    ///   - attribution: Identifies the caller as a PayPal partner.
    ///   - prefer: The value of the `Prefer` header. Defaults to `.minimal`.
    ///
    /// - Returns: The `Order` object created by PayPal, wrapped in an `EventLoopFuture`.
    public func create(
        order: Order.Request, attribution: String? = nil, prefer: PreferResponse = .minimal
    ) -> EventLoopFuture<Order> {
        var headers: HTTPHeaders = ["Content-Type": MediaType.json.serialize(), "Prefer": prefer.rawValue]
        if let attribution = attribution {
            headers.add(name: .paypalAttribution, value: attribution)
        }
        
        return self.client.post(self.path, headers: headers, body: order, as: Order.self)
    }
}
