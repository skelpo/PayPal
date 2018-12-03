import Vapor

/// The merchant-proposed offer for a dispute.
public struct Offer: Content, Equatable {
    
    /// The customer-requested refund for this dispute.
    public var buyerAmount: CurrencyCodeAmount?
    
    /// The merchant-offered refund for this dispute.
    public var sellerAmount: CurrencyCodeAmount?
    
    /// The merchant-proposed offer type for the dispute.
    public var type: OfferType?
    
    /// Creates a new `Offer` instance,
    ///
    ///     Offer(buyerAmount: Money(currency: .usd, value: "10.99"), sellerAmount: Money(currency: .usd, value: "10.99"), type: .refund)
    public init(buyerAmount: CurrencyCodeAmount?, sellerAmount: CurrencyCodeAmount?, type: OfferType?) {
        self.buyerAmount = buyerAmount
        self.sellerAmount = sellerAmount
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case buyerAmount = "buyer_requested_amount"
        case sellerAmount = "seller_offered_amount"
        case type = "offer_type"
    }
}
