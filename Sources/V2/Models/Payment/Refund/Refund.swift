import PayPal

/// A refunded payment.
public struct Refund: Codable {
    /// The status for the authorized payment.
    public let status: PaymentStatus?
    
    /// The details of the captured payment status.
    public let statusDetails: PaymentStatusDetails?
    
    /// The PayPal-generated ID for the authorized payment.
    public let id: String?
    
    /// The amount for this authorized payment.
    public let amount: CurrencyCodeAmount?
    
    /// The API caller-provided external invoice number for this order.
    /// Appears in both the payer's transaction history and the emails that the payer receives.
    public let invoice: String?
    
    /// The reason for the refund. Appears in both the payer's transaction history and the emails that the payer receives.
    public let note: String?
    
    /// The level of protection offered as defined by
    /// [PayPal Seller Protection for Merchants](https://www.paypal.com/us/webapps/mpp/security/seller-protection).
    public let sellerProtection: SellerProtection?
    
    /// An array of related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    /// The date and time when the transaction occurred,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let created: ISO8601Date?
    
    /// The date and time when the transaction was last updated,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let updated: ISO8601Date?
    
    /// Creates a new `Authorization` instance.
    ///
    /// - Parameters:
    ///   - status: The status for the authorized payment.
    ///   - amount: The PayPal-generated ID for the authorized payment.
    ///   - invoice: The amount for this authorized payment.
    ///   - note: The reason for the refund.
    ///   - sellerProtection: The level of protection offered as defined by PayPal Seller Protection for Merchants.
    ///   - expiration: The date and time when the authorized payment expires.
    ///   - links: An array of related HATEOAS links.
    ///   - created: The date and time when the transaction occurred.
    ///   - updated: The date and time when the transaction was last updated.
    public init(
        status: PaymentStatus?,
        statusDetails: PaymentStatusDetails?,
        amount: CurrencyCodeAmount?,
        invoice: String?,
        note: String?,
        sellerProtection: SellerProtection?,
        links: [LinkDescription]?,
        created: ISO8601Date?,
        updated: ISO8601Date?
        ) {
        self.id = nil
        self.status = status
        self.statusDetails = statusDetails
        self.amount = amount
        self.invoice = invoice
        self.note = note
        self.sellerProtection = sellerProtection
        self.links = links
        self.created = created
        self.updated = updated
    }
    
    enum CodingKeys: String, CodingKey {
        case status, id, amount, links
        case statusDetails = "status_details"
        case invoice = "invoice_id"
        case note = "note_to_payer"
        case sellerProtection = "seller_protection"
        case created = "create_time"
        case updated = "update_time"
    }
}
