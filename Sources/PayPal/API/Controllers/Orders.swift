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
    
    /// Creates an order.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that includes the PayPal-generated order ID,
    /// an array of purchase unit objects, payment details, customer information, metadata, and order status.
    ///
    /// - Parameters:
    ///   - order: The data for the new order to create. `units` and `redirects` properties are required.
    ///   - id: For tracking transactions which are associtaed with the partner who the ID belongs to.
    ///
    /// - Returns: The new order created by PayPal, wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func create(order: Order, partnerID id: String?) -> Future<Order> {
        return Future.flatMap(on: self.container) { () -> Future<Order> in
            let client = try self.container.make(PayPalClient.self)
            let headers: HTTPHeaders = id == nil ? [:] : ["PayPal-Partner-Attribution-Id": id!]
            
            if order.units == nil || order.redirects == nil {
                var order = order
                if order.units == nil { order.units = [] }
                if order.redirects == nil { order.redirects = Order.Redirects(return: nil, cancel: nil) }
                
                return try client.post(self.path(), headers: headers, body: order, as: Order.self)
            } else {
                return try client.post(self.path(), headers: headers, body: order, as: Order.self)
            }
        }
    }
}

