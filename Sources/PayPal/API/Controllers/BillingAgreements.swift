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
    
    /// See `PayPalController.container`.
    public var container: Container
    
    /// See `PayPalController.resource`.
    public var resource: String
    
    /// See `PayPalController.init(container:)`.
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
    
    /// Shows details for a billing agreement, by ID.
    ///
    /// A successful request returns the HTTP 200 OK status code and a JSON response body
    /// [which is decoded to a `BillingAgreement` object] that shows billing agreement details.
    ///
    /// - Parameter id: The ID of the agreement for which to show details.
    ///
    /// - Returns: The billing agreement for the ID passed in, wrapped in a future.
    ///   If an error is returned in the response, it is converted to a Swift error
    ///   and is tha value that the future wraps instead.
    public func get(agreement id: String) -> Future<BillingAgreement> {
        return Future.flatMap(on: self.container) { () -> Future<BillingAgreement> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path() + id, as: BillingAgreement.self)
        }
    }
    
    /// Bills the balance for an agreement, by ID. In the JSON request body, include an optional note
    /// that describes the reason for the billing action and the agreement amount and currency.
    ///
    /// A successful request returns the HTTP `204 No Content` status code with no JSON response body.
    ///
    /// - Parameters:
    ///   - agreementID: The ID of the billing agreement to send a bill for.
    ///   - reason: The reason for the agreement state change. Maximum length: 128.
    ///
    /// - Returns: The HTTP status code of the response, which will be 204. If an error was returned in the
    ///   response, it will get conveted to a Swift error and be returned in the future instead.
    public func billBalance(for agreementID: String, reason: String?) -> Future<HTTPStatus> {
        return Future.flatMap(on: self.container) { () -> Future<HTTPStatus> in
            guard reason?.count ?? 0 <= 128 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`note` property must have a length of 128 or less")
            }
            
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path() + agreementID + "/bill-balance", body: ["note": reason], as: HTTPStatus.self)
        }
    }
    
    /// Cancels a billing agreement, by ID. In the JSON request body, include an `agreement_state_descriptor`
    /// object with an optional note that describes the reason for the cancellation and the agreement amount and currency.
    ///
    /// A successful request returns the HTTP 204 No Content status code with no JSON response body.
    ///
    /// - Parameters:
    ///   - id: The ID of the agreement to cancel.
    ///   - reason: The reason for the agreement state change. Maximum length: 128.
    ///
    /// - Returns: The HTTP status code of the response, which will be 204. If an error was returned in the
    ///   response, it will get conveted to a Swift error and be returned in the future instead.
    public func cancel(agreement id: String, reason: String?) -> Future<HTTPStatus> {
        return Future.flatMap(on: self.container) { () -> Future<HTTPStatus> in
            guard reason?.count ?? 0 <= 128 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`note` property must have a length of 128 or less")
            }
            
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path() + id + "/cancel", body: ["note": reason], as: HTTPStatus.self)
        }
    }
    
    /// Reactivates a suspended billing agreement, by ID. In the JSON request body, include an `agreement_state_descriptor`
    /// object with with a note that describes the reason for the reactivation and the agreement amount and currency.
    ///
    /// A successful request returns the HTTP `204 No Content` status code with no JSON response body.
    ///
    /// - Parameters:
    ///   - id: The ID of the billing agreement to reactivate.
    ///   - reason: The reason for the agreement state change. Maximum length: 128.
    ///
    /// - Returns: The HTTP status code of the API response, which will be 204. If an error was returned in the
    ///   response, it will get conveted to a Swift error and be returned in the future instead.
    public func reactivate(agreement id: String, reason: String?) -> Future<HTTPStatus> {
        return Future.flatMap(on: self.container) { () -> Future<HTTPStatus> in
            guard reason?.count ?? 0 <= 128 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`note` property must have a length of 128 or less")
            }
            
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path() + id + "/re-activate", body: ["note": reason], as: HTTPStatus.self)
        }
    }
}
