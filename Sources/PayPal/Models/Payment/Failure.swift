import Vapor

extension Payment {
    
    /// The reason code for a payment failure.
    public enum Failure: String, Hashable, CaseIterable, Content {
        
        /// `UNABLE_TO_COMPLETE_TRANSACTION`.
        case unableToComplete = "UNABLE_TO_COMPLETE_TRANSACTION"
        
        /// `INVALID_PAYMENT_METHOD`.
        case invalidMethod = "INVALID_PAYMENT_METHOD"
        
        /// `PAYER_CANNOT_PAY`.
        case cannotPay = "PAYER_CANNOT_PAY"
        
        /// `CANNOT_PAY_THIS_PAYEE`.
        case cannotPayPayee = "CANNOT_PAY_THIS_PAYEE"
        
        /// `REDIRECT_REQUIRED`.
        case redirect = "REDIRECT_REQUIRED"
        
        /// `PAYEE_FILTER_RESTRICTIONS`.
        case filterRestriction = "PAYEE_FILTER_RESTRICTIONS"
    }
}
