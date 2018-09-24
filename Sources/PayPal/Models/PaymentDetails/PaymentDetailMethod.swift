import Vapor

extension PaymentDetail {
    
    /// The method or mode of a payment.
    public enum Method: String, Hashable, CaseIterable, Content {
        
        /// `BANK_TRANSFER`
        case bankTransfer = "BANK_TRANSFER"
        
        /// `CASH`
        case cash = "CASH"
        
        /// `CHECK`
        case check = "CHECK"
        
        /// `CREDIT_CARD`
        case creditCard = "CREDIT_CARD"
        
        /// `DEBIT_CARD`
        case debitCard = "DEBIT_CARD"
        
        /// `PAYPAL`
        case paypal = "PAYPAL"
        
        /// `WIRE_TRANSFER`
        case wireTransfer = "WIRE_TRANSFER"
        
        /// `OTHER`
        case other = "OTHER"
    }
}
