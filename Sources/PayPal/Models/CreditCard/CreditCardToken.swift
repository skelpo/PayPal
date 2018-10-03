import Vapor

extension CreditCard {
    
    /// Tokenized credit card details.
    public struct Token: Content, Equatable {
        
        /// The last four digits of the stored credit card number.
        public let suffix: String?
        
        /// The credit card type. Value is `visa`, `mastercard`, `discover`, or `amex`. Do not use these lowercase values for display.
        public let type: String?
        
        /// The expiration month with no leading zero. Value is from `1` to `12`.
        public let expireMonth: Int?
        
        /// The four-digit expiration year.
        public let expireYear: Int?
        
        
        /// The ID of credit card that is stored in the PayPal vault.
        ///
        /// - Warning: The use of the PayPal REST `/payments` APIs to accept credit card payments is restricted.
        ///   Instead, you can accept credit card payments with [Braintree Direct](https://www.braintreepayments.com/products/braintree-direct).
        public var creditCard: String
        
        /// A unique ID that you can assign and track when you store a credit card in the vault or use a vaulted credit card.
        /// This ID can help to avoid unintentional use or misuse of credit cards and can be any value, such as a UUID, user name, or email address.
        /// **Required** when you use a vaulted credit card and if a `payer_id` was originally provided when you vaulted the credit card.
        public var payer: String?
        
        
        /// Creates a new `CreditCard.Token` instance.
        ///
        /// - Parameters:
        ///   - creditCard: The ID of credit card that is stored in the PayPal vault.
        ///   - payer: A unique ID that you can assign and track when you store a credit card in the vault or use a vaulted credit card.
        public init(creditCard: String, payer: String?) {
            self.suffix = nil
            self.type = nil
            self.expireMonth = nil
            self.expireYear = nil
            
            self.creditCard = creditCard
            self.payer = payer
        }
        
        enum CodingKeys: String, CodingKey {
            case creditCard = "credit_card_id"
            case payer = "payer_id"
            case suffix = "last4"
            case type
            case expireMonth = "expire_month"
            case expireYear = "expire_year"
        }
    }
}
