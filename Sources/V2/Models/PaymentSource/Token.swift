import Failable

extension PaymentSource {
    
    /// A tokenized payment source to fund a payment.
    public struct Token: Codable {
        
        /// The PayPal-generated ID for the token.
        public var id: Failable<String, ID>
        
        /// The tokenization method that was used to generate the ID.
        public var type: TokenType
        
        /// Creates a new `PaymentSource.Token` instance.
        ///
        /// - Parameters:
        ///   - id: The PayPal-generated ID for the token.
        ///   - type: The tokenization method that was used to generate the ID.
        public init(id: Failable<String, ID>, type: TokenType) {
            self.id = id
            self.type = type
        }
        
        /// The validation for the `PaymentSource.Token.id` property value.
        public struct ID: LengthValidation {
            
            /// See `Validation.Suppoorted`.
            public typealias Supported = String
            
            /// See `LengthValidation.minLength`.
            public static var minLength: Int = 1
            
            /// See `LengthValidation.maxLength`.
            public static var maxLength: Int = 255
        }
    }
    
    /// The tokenization method that was used to generate the ID for a `PaymentSource.Token` instance.
    public enum TokenType: String, Hashable, CaseIterable, Codable {
        
        /// A secure, one-time-use reference to a payment source, such as payment card, PayPal account, and so on.
        case nonce = "NONCE"
        
        /// The payment method token, which is a reference to a transactional payment source.
        /// Typically stored on the merchant's server.
        case paymentMethod = "PAYMENT_METHOD_TOKEN"
        
        /// The PayPal billing agreement ID. References an approved recurring payment for goods or services.
        case billingAgreement = "BILLING_AGREEMENT"
    }
}
