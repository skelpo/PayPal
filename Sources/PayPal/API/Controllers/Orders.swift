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
    
    /// Cancels an order, by ID, and deletes the order. To call this method, the order status must be `CREATED` or `APPROVED`.
    ///
    /// A successful request returns the HTTP `204 No Content` status code with no JSON response body. If the order is already paid,
    /// the order cannot be canceled and the request returns the HTTP `422 Unprocessable Entity` status code with the message, `This order is in progress`.
    ///
    /// - Parameters:
    ///   - id: The ID of the order to cancel.
    ///
    /// - Returns: An HTTP status, which will be `204 No Content`, wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func cancel(order id: String) -> Future<HTTPStatus> {
        return Future.flatMap(on: self.container) { () -> Future<HTTPStatus> in
            let client = try self.container.make(PayPalClient.self)
            return try client.delete(self.path() + id, as: HTTPStatus.self)
        }
    }
    
    /// Shows details for an order, by ID.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows order details.
    ///
    /// - Parameters:
    ///   - orderID: The ID of the order for which to show details.
    ///
    /// - Returns: The order for the ID passed in, wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func details(for orderID: String) -> Future<Order> {
        return Future.flatMap(on: self.container) { () -> Future<Order> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path() + orderID, as: Order.self)
        }
    }
    
    /// Initiates a PayPal payment that a buyer has approved.
    ///
    /// - Note: For Marketplace use cases, use the `disbursement_mode` to indicate whether to disburse funds to the merchant and marketplace accounts
    ///   immediately or later. If you delay disbursement, you must call
    ///   [disburse funds](https://developer.paypal.com/docs/marketplaces/integrate/move-money/#3-disburse-funds) to disburse funds to the merchant and marketplace.
    ///
    /// A successful request returns the HTTP `202 Accepted` status code and a JSON response body that shows order and payment details.
    ///
    /// - Note: Applies to existing asynchronous payment processing integrations.
    ///
    /// - Parameters:
    ///   - id: The ID of the order for which to execute a payment.
    ///   - body: The information used to make the payment to the specified order.
    ///   - partner: For tracking transactions which are associtaed with the partner who the ID belongs to.
    ///   - request: A user-generated ID that you can use to enforce idempotency.
    ///
    /// - Returns: The order the payment is made for, wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func pay(order id: String, with body: Order.PaymentRequest, partner partnerID: String? = nil, request requestID: String? = nil) -> Future<Order> {
        return Future.flatMap(on: self.container) { () -> Future<Order> in
            let client = try self.container.make(PayPalClient.self)
            var headers: HTTPHeaders = [:]
            
            if let partner = partnerID {
                headers.add(name: "PayPal-Partner-Attribution-Id", value: partner)
            }
            if let request = requestID {
                headers.add(name: "PayPal-Request-Id", value: request)
            }
            
            return try client.post(self.path() + id + "/pay", headers: headers, body: body, as: Order.self)
        }
    }
}

