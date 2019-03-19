/// The details of an authorized payment.
public struct Authorization: Codable {
    /// The status for the authorized payment.
    public let status: Status?
    
    /// The PayPal-generated ID for the authorized payment.
    public let id: String?
    
    /// The amount for this authorized payment.
    public let amount: CurrencyCodeAmount?
    
    /// The API caller-provided external invoice number for this order.
    /// Appears in both the payer's transaction history and the emails that the payer receives.
    public let invoice: String?
    
    /// The level of protection offered as defined by
    /// [PayPal Seller Protection for Merchants](https://www.paypal.com/us/webapps/mpp/security/seller-protection).
    public let sellerProtection: SellerProtection?
    
    /// The date and time when the authorized payment expires,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let expiration: ISO8601Date?
    
    /// An array of related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    /// The date and time when the transaction occurred,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let created: ISO8601Date?
    
    /// The date and time when the transaction was last updated,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let updated: ISO8601Date?
    
    public init(
        status: Status?,
        amount: CurrencyCodeAmount?,
        invoice: String?,
        sellerProtection: SellerProtection?,
        expiration: ISO8601Date?,
        links: [LinkDescription]?,
        created: ISO8601Date?,
        updated: ISO8601Date?
    ) {
        self.id = nil
        self.status = status
        self.amount = amount
        self.invoice = invoice
        self.sellerProtection = sellerProtection
        self.expiration = expiration
        self.links = links
        self.created = created
        self.updated = updated
    }
    
    enum CodingKeys: String, CodingKey {
        case status, id, amount, links
        case invoice = "invoice_id"
        case sellerProtection = "seller_protection"
        case expiration = "expiration_time"
        case created = "create_time"
        case updated = "update_time"
    }
}
