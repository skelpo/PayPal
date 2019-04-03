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
    
    /// Updates an order with the `CREATED` or `APPROVED` status. You cannot update an order with the `COMPLETED` status.
    ///
    /// To make an update, you must provide a `reference_id`. If you omit a `reference_id` for an order with one purchase unit,
    /// PayPal defaults to a `reference_id` of `1`, which enables you to use a path:
    ///
    ///     "path": "/purchase_units/@reference_id=='1'/{attribute-or-object}"
    ///
    /// You can patch these attributes and objects to complete these operations:
    /// - `intent` — replace.
    /// - `purchase_units` — replace, add.
    /// - `purchase_units[].custom_id` — replace, add, remove.
    /// - `purchase_units[].description` — replace, add, remove.
    /// - `purchase_units[].payee.email` — replace, add.
    /// - `purchase_units[].shipping` — replace, add, remove.
    /// - `purchase_units[].soft_descriptor` — replace, add, remove.
    /// - `purchase_units[].amount` — replace.
    /// - `purchase_units[].invoice_id` — replace, add, remove.
    /// - `purchase_units[].payment_instruction` — replace.
    /// - `purchase_units[].payment_instruction.disbursement_mode` — replace.
    ///   - Note: By default, `disbursement_mode` is `INSTANT`.
    /// - `purchase_units[].payment_instruction.platform_fees` — replace, add, remove.
    ///
    /// A successful request returns the HTTP 204 No Content status code with an empty object in the JSON response body.
    ///
    /// - Parameters:
    ///   - order: The ID of the order to update.
    ///   - patches: An array of JSON patch objects to apply partial updates to resources.
    ///
    /// - Returns: A void `EventLoopFuture` that succedes when the update completes.
    public func update(order: String, with patches: [Patch]) -> EventLoopFuture<Void> {
        return self.client.post(self.path + order, body: patches, as: HTTPStatus.self).transform(to: ())
    }
}
