import Vapor

public struct TransactionInfo: Content, Equatable {
    public let items: [Item]?
    
    public var buyerID: String?
    public var sellerID: String?
    public var created: String?
    public var status: Status?
    public var gross: Money?
    public var invoice: String?
    public var custom: String?
    public var buyer: Buyer?
    public var seller: Seller?
    
    public init(
        buyerID: String?,
        sellerID: String?,
        created: String?,
        status: Status?,
        gross: Money?,
        invoice: String?,
        custom: String?,
        buyer: Buyer?,
        seller: Seller?
    ) {
        self.items = nil
        
        self.buyerID = buyerID
        self.sellerID = sellerID
        self.created = created
        self.status = status
        self.gross = gross
        self.invoice = invoice
        self.custom = custom
        self.buyer = buyer
        self.seller = seller
    }
}
