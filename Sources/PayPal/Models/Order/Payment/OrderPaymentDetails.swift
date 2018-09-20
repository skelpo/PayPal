import Vapor

extension Order {
    
    /// The payment details for the order.
    public struct PaymentDetails: Content, Equatable {
        
        /// The payment ID for the order.
        public let payment: String?
        
        /// Indicates whether to disburse the payment instantly or delay the payment.
        public let disbursement: DisbursementMode?
        
        enum CodingKeys: String, CodingKey {
            case payment = "payment_id"
            case disbursement = "disbursement_mode"
        }
    }
}

extension Order {
    
    /// Indicates whether to disburse an order payment instantly or delay the payment.
    public enum DisbursementMode: String, Hashable, CaseIterable, Content {
        
        /// The payment is disbursed instantly.
        case instant = "INSTANT"
        
        /// The payment is delayed.
        case delayed = "DELAYED"
    }
}
