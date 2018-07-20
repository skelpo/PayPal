import Vapor

/// Use billing plans and billing agreements to create an agreement for a recurring PayPal
/// or debit card payment for goods or services. To create an agreement, you reference an
/// active [billing plan](https://developer.paypal.com/docs/api/payments.billing-plans/v1/)
/// from which the agreement inherits information. You also supply customer and payment information
/// and, optionally, can override the referenced plan's merchant preferences and shipping fee and
/// tax information. For more information, see [Billing Plans and Agreements](https://developer.paypal.com/docs/subscriptions/).
///
/// - Warning: The use of the PayPal REST `/payments` APIs to accept credit card payments is restricted.
///   Instead, you can accept credit card payments with [Braintree Direct](https://www.braintreepayments.com/products/braintree-direct).
///
/// - Note: The Billing Agreements API does not support the `payee` object.
public final class BillingAgreements: PayPalController {
    public var container: Container
    public var resource: String
    
    public init(container: Container) {
        self.container = container
        self.resource = "payments//billing-agreements"
    }
    
    /// Creates a billing agreement.
    ///
    /// A successful request returns the HTTP `201 Created` status code and a JSON response body
    /// [which is decoded to a `BillingAgreement` object] that shows billing agreement details including a billing agreement
    /// id and redirect links to get the buyer's approval.
    ///
    /// - Parameter agreement: The object that is used as the request body
    ///   to create a new billing agreement.
    ///
    /// - Returns: The billing agreement that was created, wrapped in a future. If an error occured
    ///   while creating the agreement, that is wrapped in the future instead.
    public func create(with agreement: NewAgreement) -> Future<BillingAgreement> {
        return Future.flatMap(on: container) { () -> Future<BillingAgreement> in
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path(), body: agreement, as: BillingAgreement.self)
        }
    }
    
    /// Updates details of a billing agreement, by ID. Details include the description, shipping address, start date, and so on.
    ///
    /// A successful request returns the HTTP 200 OK status code with no JSON response body.
    ///
    /// - Parameters:
    ///   - id: The ID of the billing agreement to update.
    ///   - patches: The JSON keys to update, and how to update them. See `Patch`.
    ///
    /// - Returns: The HTTP status code of the response, which will be 200. If an error was returned in the
    ///   response, it will get conveted to a Swift error and be returned in the future instead.
    public func update(agreement id: String, with patches: [Patch]) -> Future<HTTPStatus> {
        return Future.flatMap(on: self.container) { () -> Future<HTTPStatus> in
            let client = try self.container.make(PayPalClient.self)
            return try client.patch(self.path() + id, body: ["patch_request": patches], as: HTTPStatus.self)
        }
    }
}
