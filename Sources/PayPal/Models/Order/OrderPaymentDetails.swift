import Vapor

extension Order {
    public struct PaymentDetails {}
}

extension Order.PaymentDetails {
    
    /// Indicates whether to disburse an order payment instantly or delay the payment.
    public enum DisbursementMode: String, Hashable, CaseIterable, Content {
        
        /// The payment is disbursed instantly.
        case instant = "INSTANT"
        
        /// The payment is delayed.
        case delayed = "DELAYED"
    }
}
