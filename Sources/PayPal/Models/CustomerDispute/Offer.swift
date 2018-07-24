import Vapor

public struct Offer: Content, Equatable {
    public var buyerAmount: Money?
    public var sellerAmount: Money?
    public var type: OfferType?
    
    public init(buyerAmount: Money?, sellerAmount: Money?, type: OfferType?) {
        self.buyerAmount = buyerAmount
        self.sellerAmount = sellerAmount
        self.type = type
    }
}
