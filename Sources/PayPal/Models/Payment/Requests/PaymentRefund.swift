import Vapor

extension Payment {
    
    /// The request body used to refund payments, on API endpoints such as `POST /v1/payments/sale/{sale_id}/refund`.
    public struct Refund: Content, Equatable {
        
        /// The refund amount. Includes both the amount to refund to the payer and the fee amount to refund to the payee.
        public var amount: DetailedAmount?
        
        /// The refund description. Value is a string of single-byte alphanumeric characters.
        ///
        /// Maximum length: 255.
        public var description: Failable<String?, NotNilValidate<Length255>>
        
        /// The refund reason description.
        ///
        /// Maximum length: 30.
        public var reason: Failable<String?, NotNilValidate<Length30>>
        
        /// The invoice number that tracks this payment. Value is a string of single-byte alphanumeric characters.
        ///
        /// Maximum length: 127.
        public var invoice: Optional127String
        
        
        /// Creates a new `Payment.Refund` instance.
        ///
        /// - Parameters:
        ///   - amount: The refund amount.
        ///   - description: The refund description.
        ///   - reason: The refund reason description.
        ///   - invoice: The invoice number that tracks this payment.
        public init(
            amount: DetailedAmount?,
            description: Failable<String?, NotNilValidate<Length255>>,
            reason: Failable<String?, NotNilValidate<Length30>>,
            invoice: Optional127String
        ) {
            self.amount = amount
            self.description = description
            self.reason = reason
            self.invoice = invoice
        }
        
        enum CodingKeys: String, CodingKey {
            case amount, description, reason
            case invoice = "invoice_number"
        }
    }
}
