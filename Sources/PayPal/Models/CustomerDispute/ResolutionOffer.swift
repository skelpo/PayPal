import Vapor

extension CustomerDispute {
    
    /// The body of the a request for the `POST /v1/customer/disputes/{dispute_id}/make-offer` endpoint.
    public struct ResolutionOffer: Content, ValidationSetable, Equatable {
        
        /// The merchant's notes about the offer. PayPal can, but the customer cannot, view these notes.
        ///
        /// To set the value of this property, use the `ResolutionOffer.set(_:)` method. This will
        /// validate the new value before assigning it to the property.
        ///
        /// Minimum length: 1. Maximum length: 2000.
        public private(set) var note: String
        
        /// The amount proposed to resolve the dispute.
        public var amount: Money
        
        /// The type of offer that the merchant proposes for the dispute.
        public var type: Offer.OfferType
        
        /// The return address for the item. Required when the customer must return an item to the merchant for the
        /// `MERCHANDISE_OR_SERVICE_NOT_AS_DESCRIBED` dispute reason, especially if the refund amount is less than the dispute amount.
        public var returnAddress: Address?
        
        /// The merchant-provided ID of the invoice for the refund. This optional value maps the refund to an invoice ID in the merchant's system.
        public var invoiceID: String?
        
        
        /// Creates a new `CustomerDispute.ResolutionOffer` instance.
        ///
        ///     CustomerDispute.ResolutionOffer(
        ///         note: "Offer refund with replacement item.",
        ///         amount: Money(currency: .usd, value: "23"),
        ///         type: .refundWithReplacement,
        ///         returnAddress: nil,
        ///         invoiceID: nil
        ///     )
        public init(note: String, amount: Money, type: Offer.OfferType, returnAddress: Address?, invoiceID: String?)throws {
            self.note = note
            self.amount = amount
            self.type = type
            self.returnAddress = returnAddress
            self.invoiceID = invoiceID
            
            try self.set(\.note <~ note)
        }
        
        /// See [`Decoder.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let note = try container.decode(String.self, forKey: .note)
            
            self.note = note
            self.amount = try container.decode(Money.self, forKey: .amount)
            self.type = try container.decode(Offer.OfferType.self, forKey: .type)
            self.returnAddress = try container.decodeIfPresent(Address.self, forKey: .returnAddress)
            self.invoiceID = try container.decodeIfPresent(String.self, forKey: .invoiceID)
            
            try self.set(\.note <~ note)
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<CustomerDispute.ResolutionOffer> {
            var validations = SetterValidations(ResolutionOffer.self)
            
            validations.set(\.note) { note in
                guard note.count <= 2000 && note.count >= 1 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`note` property must have a length between 1 and 2000")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case note
            case amount = "offer_amount"
            case type = "offer_type"
            case returnAddress = "return_shipping_address"
            case invoiceID = "invoice_id"
        }
    }
}
