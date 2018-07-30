import Vapor

extension CustomerDispute {
    public struct ResolutionOffer: Content, Equatable {
        public var note: String
        public var amount: Money
        public var type: Offer.OfferType
        public var returnAddress: Address?
        public var invoiceID: String?
        
        public init(note: String, amount: Money, type: Offer.OfferType, returnAddress: Address?, invoiceID: String?) {
            self.note = note
            self.amount = amount
            self.type = type
            self.returnAddress = returnAddress
            self.invoiceID = invoiceID
        }
    }
}
