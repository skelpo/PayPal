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
