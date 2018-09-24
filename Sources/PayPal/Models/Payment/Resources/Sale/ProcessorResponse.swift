import Vapor

extension RelatedResource.Sale {
    
    /// The processor-provided response codes that describe a submitted payment.
    public struct ProcessorResponse: Content, Equatable {
        
        /// The PayPal normalized response code, which is generated from the processor's specific response code.
        ///
        /// Maximum length: 4.
        public let code: String
        
        /// The [Address Verification System (AVS)](https://developer.paypal.com/webapps/developer/docs/classic/api/AVSResponseCodes/) response code.
        ///
        /// Maximum length: 1. Pattern: `[A-z0-9]{1}`.
        public let avs: String?
        
        /// The [CVV](https://developer.paypal.com/webapps/developer/docs/classic/api/AVSResponseCodes/) system response code.
        ///
        /// Maximum length: 1. Pattern: `[A-z0-9]{1}`.
        public let cvv: String?
        
        /// The merchant advice on how to handle declines for recurring payments.
        public let advice: AdviceCode?
        
        /// The processor-provided authorization response.
        public let eci: String?
        
        /// The processor-provided Visa Payer Authentication Service (VPAS) status.
        public let vpas: String?
        
        enum CodingKeys: String, CodingKey {
            case code = "response_code"
            case avs = "avs_code"
            case cvv = "cvv_code"
            case advice = "advice_code"
            case eci = "eci_submitted"
            case vpas
        }
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
