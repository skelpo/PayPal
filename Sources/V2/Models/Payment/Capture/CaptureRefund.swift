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
}
