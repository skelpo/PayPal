import Vapor

extension CustomerDispute {
    
    /// The body of the a request for the `POST /v1/customer/disputes/{dispute_id}/make-offer` endpoint.
    public struct ResolutionOffer: Content, Equatable {
        
        /// The merchant's notes about the offer. PayPal can, but the customer cannot, view these notes.
        ///
        /// Minimum length: 1. Maximum length: 2000.
        public var note: Failable<String, Length1To2000>
        
        /// The amount proposed to resolve the dispute.
        public var amount: CurrencyCodeAmount
        
        /// The type of offer that the merchant proposes for the dispute.
        public var type: Offer.OfferType
        
        /// The return address for the item. Required when the customer must return an item to the merchant for the
        /// `MERCHANDISE_OR_SERVICE_NOT_AS_DESCRIBED` dispute reason, especially if the refund amount is less than the dispute amount.
        public var returnAddress: Address?
        
        /// The merchant-provided ID of the invoice for the refund. This optional value maps the refund to an invoice ID in the merchant's system.
        public var invoiceID: String?
        
        
        /// Creates a new `CustomerDispute.ResolutionOffer` instance.
        ///
        /// - Parameters:
        ///   - note: The merchant's notes about the offer.
        ///   - amount: The amount proposed to resolve the dispute.
        ///   - type: The type of offer that the merchant proposes for the dispute.
        ///   - returnAddress: The return address for the item.
        ///   - invoiceID: The merchant-provided ID of the invoice for the refund.
        public init(note: Failable<String, Length1To2000>, amount: CurrencyCodeAmount, type: Offer.OfferType, returnAddress: Address?, invoiceID: String?) {
            self.note = note
            self.amount = amount
            self.type = type
            self.returnAddress = returnAddress
            self.invoiceID = invoiceID
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
