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
    public var created: ISO8601Date?
    
    /// The transaction status.
    public var status: Status?
    
    /// The gross amount of the transaction.
    public var gross: CurrencyCodeAmount?
    
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
    /// - Parameters:
    ///   - buyerID: The ID, as seen by the customer, for this transaction.
    ///   - sellerID: The ID, as seen by the merchant, for this transaction.
    ///   - created: The date and time when the transaction was created.
    ///   - status: The transaction status.
    ///   - gross: The gross amount of the transaction.
    ///   - invoice: The ID of the invoice for the payment.
    ///   - custom: A free-text field that is entered by the merchant during checkout.
    ///   - buyer: The details for the customer who funds the payment.
    ///   - seller: The details for the merchant who receives the funds and fulfills the order.
    public init(
        buyerID: String?,
        sellerID: String?,
        created: Date?,
        status: Status?,
        gross: CurrencyCodeAmount?,
        invoice: String?,
        custom: String?,
        buyer: Buyer?,
        seller: Seller?
    ) {
        self.items = nil
        
        self.buyerID = buyerID
        self.sellerID = sellerID
        self.created = created == nil ? nil : ISO8601Date(created!)
        self.status = status
        self.gross = gross
        self.invoice = invoice
        self.custom = custom
        self.buyer = buyer
        self.seller = seller
    }
    
    enum CodingKeys: String, CodingKey {
        case custom, buyer, seller, items
        case buyerID = "buyer_transaction_id"
        case sellerID = "seller_transaction_id"
        case created = "create_time"
        case status = "transaction_status"
        case gross = "gross_amount"
        case invoice = "invoice_number"
    }
}
