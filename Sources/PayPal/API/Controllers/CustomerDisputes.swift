import Vapor

/// Occasionally, something goes wrong with a customer's order. To dispute a charge, a customer can create a dispute with PayPal.
/// PayPal merchants, partners, and external developers can use the PayPal Customer Disputes API to manage customer disputes.
///
/// - Note: Merchants cannot create disputes but can only respond to customer-created disputes.
///
/// A customer can also ask his or her bank or credit card company to dispute and reverse a charge, which is known as a chargeback. For more information,
/// see [Disputes, claims, chargebacks, and bank reversals](https://www.paypal.com/us/brc/article/customer-disputes-claims-chargebacks-bank-reversals).
///
/// When a customer disputes a charge, you can use this API to provide evidence that the charge is legitimate. To provide evidence or
/// appeal a dispute, you submit a proof of delivery or proof of refund document or notes, which can include logs.
///
/// Normally, an agent at PayPal updates the status of disputes and settles them, but now you can run test cases in the sandbox that complete these operations.
///
/// For details, see [Customer Disputes Integration Guide](https://developer.paypal.com/docs/integration/direct/customer-disputes/)
/// and the [Marketplace Disputes Integration Guide](https://developer.paypal.com/docs/marketplaces/how-to/manage-disputes/).
///
///
/// Use the `/customer/disputes/` resource to list disputes, show dispute details, send a message to the other party, make an offer to resolve a dispute,
/// escalate a dispute to a claim, provide evidence, accept a claim, and appeal a dispute. Normally, an agent at PayPal updates the status of disputes and
/// settles them, but now you can run test cases in the sandbox that update the dispute status and settle disputes.
public final class CustomerDisputes: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"customer/disputes"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public init(container: Container) {
        self.container = container
        self.resource = "customer/disputes"
    }
    
    
    /// Lists disputes with a full or summary set of details. Default is a summary set of details, which shows
    /// the `dispute_id`, `reason`, `status`, `dispute_amount`, `create_time`, and `update_time fields`.
    ///
    /// To filter the disputes in the response, specify one or more optional query parameters.
    /// To limit the number of disputes in the response, specify the `page_size` query parameter.
    ///
    /// To list multiple disputes, set these query parameters in the request:
    /// - `page_size=2`
    /// - `start_time` instead of `disputed_transaction_id`
    ///
    /// If the response contains more than two disputes, it lists two disputes and includes a HATEOAS link to the next page of results.
    ///
    /// The querystring parameters that this endpoint can use are `startTime`, `pageSize`, and `page`. Along with these standard querystrings,
    /// there are two parameters that are endpoint specific:
    /// - `disputed_transaction_id`: Filters the disputes in the response by a transaction, by ID.
    ///    You can specify either but not both the start_time and disputed_transaction_id query parameter.
    /// - `dispute_state`: Filters the disputes in the response by a state. The allowed values are:
    ///    - `REQUIRED_ACTION`: Filters the disputes in the response in REQUIRED_ACTION dispute_state
    ///    - `REQUIRED_OTHER_PARTY_ACTION`: Filters the disputes in the response in REQUIRED_OTHER_PARTY_ACTION state
    ///    - `UNDER_PAYPAL_REVIEW`: Filters the disputes in the response in UNDER_PAYPAL_REVIEW state
    ///    - `RESOLVED`: Filters the disputes in the response in RESOLVED state
    ///    - `OPEN_INQUIRIES`: Filters the disputes in the response in OPEN_INQUIRIES state
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that lists disputes with a full or summary set of details.
    /// Default is a summary set of details, which shows the `dispute_id`, `reason`, `status`, `dispute_amount`, `create_time`, and `update_time`
    /// fields for each dispute.
    ///
    /// - Parameter parameters: The querystring paramaters sent with the request.
    ///
    /// - Returns: A list of customer disputes wrapped in a future. If an error response was sent back instead, it gets converted
    ///   to a Swift error and the future wraps that instead.
    public func list(parameters: QueryParamaters = QueryParamaters()) -> Future<CustomerDisputeList> {
        return Future.flatMap(on: self.container) { () -> Future<CustomerDisputeList> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path(), parameters: parameters, as: CustomerDisputeList.self)
        }
    }
    
    /// Shows details for a dispute, by ID.
    ///
    /// - Note: The fields that appear in the response depend on whether you access this call through first- or third-party access.
    ///   For example, if the merchant shows dispute details through third-party access, the customer's email ID does not appear.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body with dispute details.
    ///
    /// - Returns: A lcustomer dispute wrapped in a future. If an error response was sent back instead, it gets converted
    ///   to a Swift error and the future wraps that instead.
    public func details(for disputeID: String) -> Future<CustomerDispute> {
        return Future.flatMap(on: self.container) { () -> Future<CustomerDispute> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path() + disputeID, as: CustomerDispute.self)
        }
    }
    
    /// Accepts liability for a claim, by ID, which closes the dispute in the customer’s favor.
    /// PayPal automatically refunds money to the customer from the merchant's account.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that includes a link to the dispute.
    ///
    /// - Parameters:
    ///   - disputeID: The ID of the dispute for which to accept a claim.
    ///   - body: The body of the request.
    ///
    /// - Returns: An array containing a link to the dispute.
    public func accept(claim disputeID: String, with body: AcceptDisputeBody) -> Future<[LinkDescription]> {
        return Future.flatMap(on: self.container) { () -> Future<[LinkDescription]> in
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path() + disputeID + "/accept-claim", body: body, as: [LinkDescription].self)
        }
    }
}
