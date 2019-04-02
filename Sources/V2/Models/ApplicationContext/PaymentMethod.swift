/// The customer and merchant payment preferences for a given app context.
public struct PaymentMethod: Codable {
    
    /// The customer-selected payment method on the merchant site.
    public var payer: PayerSelected?
    
    /// The merchant-preferred payment sources.
    public var payee: PayeePrefered?
    
    public init(payer: PayerSelected?, payee: PayeePrefered? = .unrestricted) {
        self.payer = payer
        self.payee = payee
    }
    
    /// The customer-selected payment methods.
    public enum PayerSelected: String, Hashable, CaseIterable, Codable {
        
        /// When payer chooses PayPal Credit as the payment method.
        case credit = "PAYPAL_CREDIT"
        
        /// When payer chooses PayPal as the payment method
        case paypal = "PAYPAL"
    }
    
    /// The merchant-preferred payment sources.
    public enum PayeePrefered: String, Hashable, CaseIterable, Codable {
        
        /// (Default) Accepts any type of payment from the customer.
        case unrestricted = "UNRESTRICTED"
        
        /// Accepts only immediate payment from the customer. For example, credit card, PayPal balance, or instant ACH.
        /// Ensures that at the time of capture, the payment does not have the `pending` status.
        case immediate = "IMMEDIATE_PAYMENT_REQUIRED"
    }
}
