import Vapor

/// The body of the request for PayPal's `POST /v1/customer/disputes/{dispute_id}/accept-claim` endpoint.
public struct AcceptDisputeBody: Content, Equatable {
    
    /// The merchant's notes about the claim. PayPal can, but the customer cannot, view these notes.
    ///
    /// Minimum length: 1. Maximum length: 2000.
    public var note: Optional2000String
    
    /// The merchant's reason for acceptance of the customer's claim.
    public var reason: Reason?
    
    /// The merchant-provided ID of the invoice for the refund. This optional value is used to
    /// map the refund to an invoice ID in the merchant's system.
    public var invoiceID: String?
    
    /// The return address for the item.
    ///
    /// Required when the customer must return an item to the merchant for the `MERCHANDISE_OR_SERVICE_NOT_AS_DESCRIBED` dispute reason,
    /// especially if the refund amount is less than the dispute amount.
    public var returnAddress: Address?
    
    /// To accept a customer's claim, the amount that the merchant agrees to refund the customer.
    ///
    /// The subsequent action depends on the amount:
    /// - If this amount is less than the customer-requested amount, the dispute updates to require customer acceptance.
    /// - If this amount is equal to or greater than the customer-requested amount,
    ///   this amount is automatically refunded to the customer and the dispute closes.
    public var refund: CurrencyCodeAmount?
    
    
    /// Creates a new `AcceptDisputeBody` instance.
    ///
    /// - Parameters:
    ///   - note: The merchant's notes about the claim.
    ///   - reason: The merchant's reason for acceptance of the customer's claim.
    ///   - invoiceID: The merchant-provided ID of the invoice for the refund.
    ///   - returnAddress: The return address for the item.
    ///   - refund: To accept a customer's claim, the amount that the merchant agrees to refund the customer.
    public init(note: Optional2000String, reason: Reason?, invoiceID: String?, returnAddress: Address?, refund: CurrencyCodeAmount?) {
        self.note = note
        self.reason = reason
        self.invoiceID = invoiceID
        self.returnAddress = returnAddress
        self.refund = refund
    }
    
    enum CodingKeys: String, CodingKey {
        case note
        case reason = "accept_claim_reason"
        case invoiceID = "invoice_id"
        case returnAddress = "return_shipping_address"
        case refund = "refund_amount"
    }
}
