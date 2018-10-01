import Vapor

/// Use the Payments REST API to easily and securely accept online and mobile payments.
/// The payments name space contains resource collections for payments, sales, refunds, authorizations, captures, and orders.
///
/// - Important: The use of the PayPal REST /payments APIs to accept credit card payments is restricted.
///   Instead, you can accept credit card payments with [Braintree Direct](https://www.braintreepayments.com/products/braintree-direct).
///
/// You can enable customers to make PayPal and credit card payments with only a few clicks, depending on the country.
/// You can accept an immediate payment or authorize a payment and capture it later. You can show details for completed payments, refunds,
/// and authorizations. You can make full or partial refunds. You also can void or re-authorize authorizations. For more information,
/// see the [Payments overview](https://developer.paypal.com/docs/integration/direct/payments/).
///
/// ## Payment
///
/// Use the `/payment` resource to create a _sale_, an _authorized payment_, or an _order_. A sale is a direct credit card payment,
/// stored credit card payment, or PayPal payment. An authorized payment places funds on hold to be captured later. An order is a purchase
/// that a customer has approved but for which the funds are not placed on hold. You can also use this resource to execute approved
/// PayPal payments and show details for, update, and list payments. For more information, see also
/// [Payments](https://developer.paypal.com/docs/integration/direct/payments/).
///
/// ## Sale
///
/// A sale is a completed payment. Use the `/sale` resource to show sale details and refund a sale. For more information, see also Refund payments.
///
/// ## Authorization
///
/// Use the `/authorization` resource and related sub-resources to show details for, capture, void, and reauthorize an authorization.
///
/// ## Orders
///
/// Use the `/orders` resource to authorize, capture, void, and show details for an order.
///
/// - Note: You cannot refund an order directly. Instead, you must refund a completed payment for an order.
///   For integration information, see Orders and refund a payment.
///
/// ## Capture
///
/// Use the `/capture` resource and sub-resources to show details for and refund captured payments.
public final class Payments: PayPalController {
    
    // MARK: - PayPalController
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"payments"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public init(container: Container) {
        self.container = container
        self.resource = "payments"
    }
    
    // MARK: - /payment
    
    /// Creates a sale, an authorized payment to be captured later, or an order.
    ///
    /// To create a sale, authorization, or order, include the payment details in the JSON request body. Set the `intent` to `sale`,
    /// `authorize`, or `order`.
    ///
    /// - Note: TPP Clients (Third Party Providers in the context of PSD2 regulation) are restricted from using `authorize` and `order` intents.
    ///
    /// Include payer, transaction details, and, for PayPal payments only, redirect URLs. The combination of the `payment_method`
    /// and `funding_instrument` determines the type of payment that is created. For more information, see
    /// [Payments REST API](https://developer.paypal.com/docs/integration/direct/payments/).
    ///
    /// - Note: Authorizations are guaranteed for up to three days, though you can attempt to capture an authorization for up to 29 days.
    ///   After the three-day honor period authorization expires, you can
    ///   [reauthorize](https://developer.paypal.com/docs/api/payments/v1/#authorization_reauthorize) the payment.
    ///
    /// A successful request returns the HTTP `201 Created` status code and a JSON response body that shows payment details.
    ///
    /// - Parameters:
    ///   - payment: The data used to create a new payment.
    ///   - partner: For tracking transactions which are associtaed with the partner who the ID belongs to.
    ///
    /// - Returns: The payment that was created, wrapped in a future. If PayPal returns an error response instead,
    ///   it will get converted to a Swift error and the future will wrap that.
    public func create(payment: Payment, partner: String? = nil) -> Future<Payment> {
        return Future.flatMap(on: self.container) { () -> Future<Payment> in
            let client = try self.container.make(PayPalClient.self)
            let headers: HTTPHeaders = partner == nil ? [:] : ["PayPal-Partner-Attribution-Id": partner!]
            
            return try client.post(self.path(for: .payment), headers: headers, body: payment, as: Payment.self)
        }
    }
    
    /// Lists payments that were created by the [create payment](https://developer.paypal.com/docs/api/payments/v1/#payment_create)
    /// call and that are in any state.
    ///
    /// The list shows the payments that are made to the merchant who makes the call.
    /// To filter the payments that appear in the response, you can specify one or more optional query and pagination parameters.
    /// See [Filtering and pagination](https://developer.paypal.com/docs/api/overview/#query-parameters).
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that lists payments with payment details.
    ///
    /// - Parameter parameters: The query parameters sent in the request URI. The parameters used are `count`, `start_id`, `start_index`,
    ///   `start_time`, `end_time`, `payee_id`, `sort_by`, and `sort_order`.
    ///
    ///   The API use 10 as the `count` if none is passed in. The max `count` is 20.
    ///
    /// - Returns: A list of payments which match the query parameters passed in, along with the amount of elements return in each
    ///   range of payments and the ID of the element to use to get the next range of results. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func list(parameters: QueryParamaters = QueryParamaters()) -> Future<PaymentList> {
        return Future.flatMap(on: self.container) { () -> Future<PaymentList> in
            guard parameters.count ?? 0 <= 20 else {
                throw PayPalError(status: .internalServerError, identifier: "invalidCount", reason: "`count` query paramater msu be 20 or less")
            }
            
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path(for: .payment), parameters: parameters, as: PaymentList.self)
        }
    }
    
    /// Partially updates a payment, by ID.
    ///
    /// You can update the amount, shipping address, invoice ID, and custom data. You cannot update a payment after the payment executes.
    ///
    /// - Note: TPP Clients (Third Party Providers in the context of PSD2 regulation) are restricted from patching amount once authorized.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows payment details.
    ///
    /// - Parameters:
    ///   - id: The ID of the payment to update.
    ///   - patches: An array of JSON patch objects to apply partial updates to resources.
    ///
    /// - Returns: The payment that was updated, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func patch(payment id: String, with patches: [Patch]) -> Future<Payment> {
        return Future.flatMap(on: self.container) { () -> EventLoopFuture<Payment> in
            let client = try self.container.make(PayPalClient.self)
            return try client.patch(self.path(for: .payment) + id, body: patches, as: Payment.self)
        }
    }
    
    /// Shows details for a payment, by ID, that has yet to complete. For example, shows details for a payment that was created, approved, or failed.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows payment details.
    ///
    /// - Parameter id: The ID of the payment for which to show details.
    ///
    /// - Returns: The payment for the ID passed in. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func get(payment id: String) -> Future<Payment> {
        return Future.flatMap(on: self.container) { () -> Future<Payment> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path(for: .payment) + id, as: Payment.self)
        }
    }
    
    /// Executes a PayPal payment that the customer has approved. You can optionally update one or more transactions when you execute the payment.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows details for the executed payment.
    ///
    /// - Parameters:
    ///   - id: The ID of the payment to execute.
    ///   - executor: Transactions to update when the payment is executed.
    ///   - request: A user-generated ID that you can use to enforce idempotency.
    ///   - partner: For tracking transactions which are associtaed with the partner who the ID belongs to.
    ///
    /// - Returns: The payment model that was executed, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func execute(payment id: String, with executor: Payment.Executor, request: String? = nil, partner: String? = nil) -> Future<Payment> {
        return Future.flatMap(on: self.container) { () -> Future<Payment> in
            let client = try self.container.make(PayPalClient.self)
            var headers: HTTPHeaders = [:]
            
            if let request = request {
                headers.add(name: "PayPal-Request-Id", value: request)
            }
            if let partner = partner {
                headers.add(name: "PayPal-Partner-Attribution-Id", value: partner)
            }
            
            return try client.post(self.path(for: .payment) + id, headers: headers, body: executor, as: Payment.self)
        }
    }
    
    // MARK: - /sale
    
    /// Shows details for a sale, by ID. Returns only sales that were created through the REST API.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows sale details.
    ///
    /// - Parameter id: The ID of the sale for which to show details.
    ///
    /// - Returns: The sale object for the ID passed in, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func get(sale id: String) -> Future<RelatedResource.Sale> {
        return Future.flatMap(on: self.container) { () -> Future<RelatedResource.Sale> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path(for: .sale) + id, as: RelatedResource.Sale.self)
        }
    }
    
    /// Refunds a sale, by ID. For a full refund, do not include the `amount` object in the JSON request body.
    /// For a partial refund, include an `amount` object in the JSON request body.
    ///
    /// A successful request returns the HTTP `201 Created` status code and a JSON response body that shows details for the refunded sale.
    ///
    /// - Parameters:
    ///   - id: The ID of the sale transaction to refund.
    ///   - refund: The refund data for the sale.
    ///   - request: A user-generated ID that you can use to enforce idempotency.
    ///
    /// - Returns: The details of the refund, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func refund(sale id: String, with refund: Payment.Refund, request: String? = nil) -> Future<Payment.RefundResult> {
        return Future.flatMap(on: self.container) { () -> Future<Payment.RefundResult> in
            let client = try self.container.make(PayPalClient.self)
            let headers: HTTPHeaders = request == nil ? [:] : ["PayPal-Request-Id": request!]
            
            return try client.post(self.path(for: .sale) + id + "/refund", headers: headers, body: refund, as: Payment.RefundResult.self)
        }
    }
    
    // MARK: - /authorization
    
    /// Shows details for an authorization, by ID.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows authorization details.
    ///
    /// - Parameter id: The ID of the authorization.
    ///
    /// - Returns: The authorization for the ID passed in, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func get(authorization id: String) -> Future<RelatedResource.Authorization> {
        return Future.flatMap(on: self.container) { () -> Future<RelatedResource.Authorization> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path(for: .authorization) + id, as: RelatedResource.Authorization.self)
        }
    }
    
    /// Captures and processes an authorization, by ID. The original payment call must specify an intent of `authorize`.
    ///
    /// A successful request returns the HTTP `201 Created` status code and a JSON response body that shows details for the captured authorization.
    ///
    /// - Parameters:
    ///   - id: The ID of the authorization to capture.
    ///   - capture: The capture data for the authorization.
    ///
    /// - Returns: The captured authorization, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func capture(authorization id: String, with capture: RelatedResource.Capture) -> Future<RelatedResource.Authorization> {
        return Future.flatMap(on: self.container) { () -> Future<RelatedResource.Authorization> in
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path(for: .authorization) + id + "/capture", body: capture, as: RelatedResource.Authorization.self)
        }
    }
    
    /// Re-authorizes a PayPal account payment, by authorization ID.
    ///
    /// To ensure that funds are still available, re-authorize a payment after the initial three-day honor period.
    /// Supports only the `amount` request parameter. You can re-authorize a payment only once from four to 29 days after three-day honor period
    /// for the original authorization expires. If 30 days have passed from the original authorization, you must create a new authorization instead.
    /// A re-authorized payment itself has a new three-day honor period. You can re-authorize a transaction once for up to 115% of the originally
    /// authorized amount, not to exceed an increase of $75 USD.
    ///
    /// A successful request returns the HTTP `201 Created` status code and a JSON response body that shows details
    /// for the re-authorized authorization.
    ///
    /// - Parameters:
    ///   - id: The ID of the authorization to re-authorize.
    ///   - authorization: The authorization details for re-authorizing.
    ///
    /// - Returns: The re-authorized authorization, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func reauthorize(authorization id: String, with authorization: RelatedResource.Authorization) -> Future<RelatedResource.Authorization> {
        return Future.flatMap(on: self.container) { () -> Future<RelatedResource.Authorization> in
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path(for: .authorization) + id + "/reauthorize", body: authorization, as: RelatedResource.Authorization.self)
        }
    }
    
    /// Voids, or cancels, an authorization, by ID. You cannot void a fully captured authorization.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows details for the voided authorization.
    ///
    /// - Parameters:
    ///   - id: The ID of the authorization to void.
    ///   - request: A user-generated ID that you can use to enforce idempotency.
    ///
    /// - Returns: The voided authorization, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func void(authorization id: String, request: String? = nil) -> Future<RelatedResource.Authorization> {
        return Future.flatMap(on: self.container) { () -> Future<RelatedResource.Authorization> in
            let client = try self.container.make(PayPalClient.self)
            let headers: HTTPHeaders = request == nil ? [:] : ["PayPal-Request-Id": request!]
            
            return try client.post(self.path(for: .authorization) + id + "/void", headers: headers, as: RelatedResource.Authorization.self)
        }
    }
    
    // MARK: - /orders
    
    /// Shows details for an order, by ID.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows details for the voided authorization.
    ///
    /// - Parameter id: The ID of the order for which to show details.
    ///
    /// - Returns: The order details for the ID, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func get(order id: String) -> Future<RelatedResource.Sale> {
        return Future.flatMap(on: self.container) { () -> Future<RelatedResource.Sale> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path(for: .orders) + id, as: RelatedResource.Sale.self)
        }
    }
    
    /// Authorizes an order, by ID. In the JSON request body, include an `amount` object.
    ///
    /// A successful request returns the HTTP `201 Created` status code and a JSON response body that shows details for the authorized order.
    ///
    /// - Parameters:
    ///   - id: The ID of the order to authorize.
    ///   - authorization: The authorization details for the order. The `processor` is not used by this endpoint.
    ///
    ///     **Note**: For an order authorization, you cannot include amount `details`.
    ///
    /// - Returns:The authorized order, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func authorize(order id: String, with authorization: RelatedResource.Authorization) -> Future<RelatedResource.Order> {
        return Future.flatMap(on: self.container) { () -> Future<RelatedResource.Order> in
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path(for: .orders) + id + "/authorize", body: authorization, as: RelatedResource.Order.self)
        }
    }
    
    /// Captures a payment for an order, by ID. To use this call, the original payment call must specify an `order` intent.
    /// In the JSON request body, include the payment amount and indicate whether this capture is the final capture for the authorization.
    ///
    /// A successful request returns the HTTP `201 Created` status code and a JSON response body that shows details for the captured order.
    ///
    /// - Parameters:
    ///   - id: The ID of the order to capture.
    ///   - capture: The capture details for the order.
    ///
    /// - Returns: The captured order, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func capture(order id: String, with capture: RelatedResource.Capture) -> Future<RelatedResource.Order> {
        return Future.flatMap(on: self.container) { () -> Future<RelatedResource.Order> in
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path(for: .orders) + id + "/capture", body: capture, as: RelatedResource.Order.self)
        }
    }
    
    /// Voids, or cancels, an order, by ID. You cannot void an order if the payment has already been partially or fully captured.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows details for the voided order.
    ///
    /// - Parameters:
    ///   - order: The ID of the order to void.
    ///   - request: A user-generated ID that you can use to enforce idempotency.
    ///
    /// - Returns: The voided order, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func void(order id: String, request: String? = nil) -> Future<RelatedResource.Order> {
        return Future.flatMap(on: self.container) { () -> Future<RelatedResource.Order> in
            let client = try self.container.make(PayPalClient.self)
            let headers: HTTPHeaders = request == nil ? [:] : ["PayPal-Request-Id": request!]
            
            return try client.post(self.path(for: .orders) + id + "/do-void", headers: headers, as: RelatedResource.Order.self)
        }
    }
    
    // MARK: - /capture
    
    /// Shows details for a captured payment, by ID.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows details for the captured payment.
    ///
    /// - Parameter id: The ID of the captured payment for which to show details.
    ///
    /// - Returns: The captured transaction, wrapped in a future. If PayPal returns an error response,
    ///   it will get converted to a Swift error and the future will wrap that instead.
    public func get(captured id: String) -> Future<RelatedResource.Capture> {
        return Future.flatMap(on: self.container) { () -> Future<RelatedResource.Capture> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path(for: .capture) + id, as: RelatedResource.Capture.self)
        }
    }
    
    // MARK: - Internal Helpers
    
    internal func path(for resource: Resource)throws -> String {
        return try self.path() + resource.rawValue + "/"
    }
    
    internal enum Resource: String {
        case payment
        case sale
        case authorization
        case orders
        case capture
        case refund
    }
}
