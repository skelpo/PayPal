import PayPal

extension Capture {
    
    /// A refund for a captured payment.
    public struct Refund: Codable {
        
        /// The amount to refund. To refund a portion of the captured amount, specify an amount.
        /// If amount is not specified, an amount equal to captured amount - previous refunds is refunded.
        /// The amount must be a positive number and in the same currency as the one in which the payment was captured.
        public var amount: CurrencyCodeAmount?
        
        /// The API caller-provided external invoice number for this order.
        /// Appears in both the payer's transaction history and the emails that the payer receives.
        public var invoice: Optional127String
        
        /// The reason for the refund. Appears in both the payer's transaction history and the emails that the payer receives.
        public var note: Failable<String?, NotNilValidate<Length255>>
        
        /// Creates a new `Capture.Refund` instance.
        ///
        /// - Parameters:
        ///   - amount: The amount to refund. If `nil`, a full refund is made.
        ///   - invoice: The API caller-provided external invoice number for this order.
        ///   - note: The reason for the refund.
        public init(
            amount: CurrencyCodeAmount?,
            invoice: Optional127String,
            note: Failable<String?, NotNilValidate<Length255>>
        ) {
            self.amount = amount
            self.invoice = invoice
            self.note = note
        }
        
        enum CodingKeys: String, CodingKey {
            case amount
            case invoice = "invoice_id"
            case note = "note_to_payer"
        }
    }
    
    /// A captured payment.
    public struct Refunded: Codable {
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

}
