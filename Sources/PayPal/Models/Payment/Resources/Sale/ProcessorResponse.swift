import Vapor

extension RelatedResource.Sale {
    public struct ProcessorResponse: Content, Equatable {
        public let code: String
        public let avs: String?
        public let cvv: String?
        public let advice: AdviceCode?
        public let eci: String?
        public let vpas: String?
    }
}

extension RelatedResource.Sale.ProcessorResponse {
    
    /// The merchant advice on how to handle declines for recurring payments.
    public enum AdviceCode: String, Hashable, CaseIterable, Content {
        
        /// 01 New account information.
        case newAccount = "01_NEW_ACCOUNT_INFORMATION"
        
        /// 02 Try again later.
        case tryAgain = "02_TRY_AGAIN_LATER"
        
        /// 02 Stop specific payment.
        case stopSpecific = "02_STOP_SPECIFIC_PAYMENT"
        
        /// 03 Do not try again.
        case dontTry = "03_DO_NOT_TRY_AGAIN"
        
        /// 03 Revoke authorization for future payment.
        case revokeAuthorization = "03_REVOKE_AUTHORIZATION_FOR_FUTURE_PAYMENT"
        
        /// 21 Do not try again. Card holder cancelled recurring charge.
        case canceledRecurring = "21_DO_NOT_TRY_AGAIN_CARD_HOLDER_CANCELLED_RECURRRING_CHARGE"
        
        /// 21 Cancel all recurring payments.
        case canceledAllRecurring = "21_CANCEL_ALL_RECURRING_PAYMENTS"
    }
}
