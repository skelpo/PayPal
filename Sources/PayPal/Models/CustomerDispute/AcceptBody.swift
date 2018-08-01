import Vapor

/// The body of the request for PayPal's `POST /v1/customer/disputes/{dispute_id}/accept-claim` endpoint.
public struct AcceptDisputeBody: Content, ValidationSetable, Equatable {
    
    /// The merchant's notes about the claim. PayPal can, but the customer cannot, view these notes.
    ///
    /// This property can be set using the `AcceptDisputeBody.set(_:)` method. This
    /// will validate the new value before assigning it to the property.
    ///
    /// Minimum length: 1. Maximum length: 2000.
    public private(set) var note: String?
    
    /// The merchant's reason for acceptance of the customer's claim.
    public var reason: Reason?
    
    /// The merchant-provided ID of the invoice for the refund. This optional value is used to map the refund to an invoice ID in the merchant's system.
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
    /// - If this amount is equal to or greater than the customer-requested amount, this amount is automatically refunded to the customer and the dispute closes.
    public var refund: Money?
    
    
    /// Creates a new `AcceptDisputeBody` instance.
    ///
    ///     AcceptDisputeBody(
    ///         note: "Refund to customer",
    ///         reason: .policy,
    ///         invoiceID: "3EC9D031-0DBF-446F-ABC0-31B4A6E0D2B5",
    ///         returnAddress: nil,
    ///         refund: Money(currency: .usd, value: "55.50")
    ///     )
    public init(note: String?, reason: Reason?, invoiceID: String?, returnAddress: Address?, refund: Money?)throws {
        self.note = note
        self.reason = reason
        self.invoiceID = invoiceID
        self.returnAddress = returnAddress
        self.refund = refund
        
        try self.set(\.note <~ note)
    }
    
    /// See [`Decoder.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let note = try container.decodeIfPresent(String.self, forKey: .note)
        
        self.note = note
        self.reason = try container.decodeIfPresent(Reason.self, forKey: .reason)
        self.invoiceID = try container.decodeIfPresent(String.self, forKey: .invoiceID)
        self.returnAddress = try container.decodeIfPresent(Address.self, forKey: .returnAddress)
        self.refund = try container.decodeIfPresent(Money.self, forKey: .refund)
        
        try self.set(\.note <~ note)
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<AcceptDisputeBody> {
        var validations = SetterValidations(AcceptDisputeBody.self)
        
        validations.set(\.note) { note in
            guard let note = note else { return }
            guard note.count >= 1 && note.count <= 2000 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`note` property must have a length between 1 and 2000")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case note
        case reason = "accept_claim_reason"
        case invoiceID = "invoice_id"
        case returnAddress = "return_shipping_address"
        case refund = "refund_amount"
    }
}
