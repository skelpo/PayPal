import Vapor

extension Payment {
    
    /// The intent of a payment.
    public enum Intent: String, Hashable, CaseIterable, Content {
        
        /// Makes an immediate payment.
        case sale
        
        /// [Authorizes a payment for capture later](https://developer.paypal.com/docs/integration/direct/payments/capture-payment/).
        case authorize
        
        /// [Creates an order](https://developer.paypal.com/docs/integration/direct/payments/orders/).
        case order
    }
}
