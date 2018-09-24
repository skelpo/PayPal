import Vapor

extension PaymentDetail {
    
    /// The type of transaction for a payment.
    public enum TransactionType: String, Hashable, CaseIterable, Content {
        
        /// `SALE`
        case sale = "SALE"
        
        /// `AUTHORIZATION`
        case authorization = "AUTHORIZATION"
        
        /// `CAPTURE`
        case capture = "CAPTURE"
    }
}
