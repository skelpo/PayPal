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
}
