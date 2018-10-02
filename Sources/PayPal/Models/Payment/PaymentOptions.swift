import Vapor

extension Payment {
    public struct Options: Content, Equatable {
        public let recurring: Bool?
        public let skipFMF: Bool?
        
        public var allowed: Method?
        
        public init(allowed: Method?) {
            self.recurring = nil
            self.skipFMF = nil
            self.allowed = allowed
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
