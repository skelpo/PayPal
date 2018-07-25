import Vapor

/// The transaction information that a dispute has occured over.
public struct TransactionInfo: Content, Equatable {
    
    /// An array of items that were purchased as part of the transaction.
    public let items: [Item]?
    
    /// The ID, as seen by the customer, for this transaction.
    public var buyerID: String?
    
    /// The ID, as seen by the merchant, for this transaction.
    public var sellerID: String?
    
    /// The date and time when the transaction was created, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// For example, `yyyy`-`MM`-`ddTHH`:`mm`:`ss`.`SSSZ`.
    public var created: String?
    
    /// The transaction status.
    public var status: Status?
    
    /// The gross amount of the transaction.
    public var gross: Money?
    
    /// The ID of the invoice for the payment.
    public var invoice: String?
    
    /// A free-text field that is entered by the merchant during checkout.
    public var custom: String?
    
    /// The details for the customer who funds the payment. For example, the customer's first name, last name, and email address.
    public var buyer: Buyer?
    
    /// The details for the merchant who receives the funds and fulfills the order. For example, merchant ID, and contact email address.
    public var seller: Seller?
    
    
    /// Creates a new `TransactionInfo` instance.
    ///
    ///     TransactionInfo(
    ///         buyerID: "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A",
    ///         sellerID: "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
    ///         created: Date().iso8601,
    ///         status: .pending,
    ///         gross: Money(currency: .usd, value: "89.45"),
    ///         invoice: "C80ED435-DBB2-456B-A1EF-2750A32AAF1A",
    ///         custom: nil,
    ///         buyer: Buyer(email: "witheringheights@exmaple.com", name: "Leeli Wingfeather"),
    ///         seller: Seller(email: "throg@exmaple.com", name: "Nag the Nameless", merchantID: nil)
    ///     )
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
