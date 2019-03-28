import PayPal

/// A captured payment.
public struct Capture: Codable {
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
    
    /// The level of protection offered as defined by
    /// [PayPal Seller Protection for Merchants](https://www.paypal.com/us/webapps/mpp/security/seller-protection).
    public let sellerProtection: SellerProtection?
    
    /// Indicates whether you can make additional captures against the authorized payment.
    /// Set to `true` if you do not intend to capture additional payments against the authorization.
    /// Set to `false` if you intend to capture additional payments against the authorization.
    public let `final`: Bool?
    
    /// The detailed breakdown of the captured payment.
    public let breakdown: SellerReceivableBreakdown?
    
    /// The funds that are held on behalf of the merchant.
    public let disbursement: DisbursementMode?
    
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
    ///   - sellerProtection: The level of protection offered as defined by PayPal Seller Protection for Merchants.
    ///   - final: Indicates whether you can make additional captures against the authorized payment.
    ///   - breakdown: The detailed breakdown of the captured payment.
    ///   - disbursement: The funds that are held on behalf of the merchant.
    ///   - links: An array of related HATEOAS links.
    ///   - created: The date and time when the transaction occurred.
    ///   - updated: The date and time when the transaction was last updated.
    public init(
        status: PaymentStatus?,
        statusDetails: PaymentStatusDetails?,
        amount: CurrencyCodeAmount?,
        invoice: String?,
        sellerProtection: SellerProtection?,
        `final`: Bool?,
        breakdown: SellerReceivableBreakdown?,
        disbursement: DisbursementMode?,
        links: [LinkDescription]?,
        created: ISO8601Date?,
        updated: ISO8601Date?
    ) {
        self.id = nil
        self.status = status
        self.statusDetails = statusDetails
        self.amount = amount
        self.invoice = invoice
        self.sellerProtection = sellerProtection
        self.`final` = `final`
        self.breakdown = breakdown
        self.disbursement = disbursement
        self.links = links
        self.created = created
        self.updated = updated
    }
    
    enum CodingKeys: String, CodingKey {
        case status, id, amount, links
        case statusDetails = "status_details"
        case invoice = "invoice_id"
        case sellerProtection = "seller_protection"
        case `final` = "final_capture"
        case breakdown = "seller_receivable_breakdown"
        case disbursement = "disbursement_mode"
        case created = "create_time"
        case updated = "update_time"
    }
}
