import PayPal

extension Authorization {
    
    /// A capture for an authorized payment.
    public struct Capture: Codable {
        
        /// The amount to capture. To capture a portion of the full authorized amount, specify an amount.
        /// If amount is not specified, the full authorized amount is captured. The amount must be a positive number
        /// and in the same currency as the authorization against which the payment is being captured.
        public let amount: CurrencyCodeAmount?
        
        /// The API caller-provided external invoice number for this order.
        /// Appears in both the payer's transaction history and the emails that the payer receives.
        public let invoice: Optional127String
        
        /// Indicates whether you can make additional captures against the authorized payment.
        /// Set to true if you do not intend to capture additional payments against the authorization.
        /// Set to false if you intend to capture additional payments against the authorization.
        public let final: Bool?
        
        /// Any additional payment instructions for PayPal for Partner customers.
        /// Enables features for partners and marketplaces, such as delayed disbursement and collection of a platform fee.
        /// Applies during order creation for captured payments or during capture of authorized payments.
        public let instruction: PaymentInstruction?
        
        /// Creates a new `Authorization.Capture` instance.
        ///
        /// - Parameters:
        ///   - amount: The amount to capture.
        ///   - invoice: The API caller-provided external invoice number for this order.
        ///   - final: Indicates whether you can make additional captures against the authorized payment. Defaults to `false`.
        ///   - instruction: Any additional payment instructions for PayPal for Partner customers.
        public init(
            amount: CurrencyCodeAmount?,
            invoice: Optional127String,
            final: Bool? = false,
            instruction: PaymentInstruction?
        ) {
            self.amount = amount
            self.invoice = invoice
            self.final = final
            self.instruction = instruction
        }
        
        enum CodingKeys: String, CodingKey {
            case amount
            case invoice = "invoice_id"
            case final = "final_capture"
            case instruction = "payment_instruction"
        }
    }
    
    /// A captured authorized payment.
    public struct Captured: Codable {
        /// The status for the authorized payment.
        public let status: Status?
        
        /// The details of the captured payment status.
        public let statusDetails: StatusDetails?
        
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
        public let disbursement: Order.DisbursementMode?
        
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
        ///   - expiration: The date and time when the authorized payment expires.
        ///   - links: An array of related HATEOAS links.
        ///   - created: The date and time when the transaction occurred.
        ///   - updated: The date and time when the transaction was last updated.
        public init(
            status: Status?,
            statusDetails: StatusDetails?,
            amount: CurrencyCodeAmount?,
            invoice: String?,
            sellerProtection: SellerProtection?,
            `final`: Bool?,
            breakdown: SellerReceivableBreakdown?,
            disbursement: Order.DisbursementMode?,
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
}
