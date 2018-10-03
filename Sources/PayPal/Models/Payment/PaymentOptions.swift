import Vapor

extension Payment {
    
    /// The payment options for a transaction.
    public struct Options: Content, Equatable {
        
        /// Undocumented by PayPal. Maybe to create a recurring payment?
        public let recurring: Bool?
        
        /// Undocumented by PayPal. Maybe used to skip fraud filters?
        public let skipFMF: Bool?
        
        
        /// The payment method for this transaction. This field does not apply to the credit card payment method.
        public var allowed: Method?
        
        
        /// Creates a new `Payment.Options` instance.
        ///
        /// - Parameter allowed: The payment method for this transaction.
        public init(allowed: Method?) {
            self.recurring = nil
            self.skipFMF = nil
            self.allowed = allowed
        }
        
        enum CodingKeys: String, CodingKey {
            case recurring = "recurring_flag"
            case skipFMF = "skip_fmf"
            case allowed = "allowed_payment_method"
        }
    }
}

extension Payment.Options {
        
    /// The payment methods for a transaction.
    public enum Method: String, Hashable, CaseIterable, Content {
        
        /// Merchant does not have a preference on how they want the customer to pay.
        case unrestricted = "UNRESTRICTED"
        
        /// Merchant requires that the customer pays with an instant funding source, such as a credit card or PayPal balance.
        /// All payments are processed instantly. However, payments that require a manual review are marked as pending.
        /// Merchants must handle the pending state as if the payment is not yet complete.
        case instantFunding = "INSTANT_FUNDING_SOURCE"
        
        /// Processes all payments immediately. Any payment that requires a manual review is marked failed.
        case immediate = "IMMEDIATE_PAY"
    }
}
