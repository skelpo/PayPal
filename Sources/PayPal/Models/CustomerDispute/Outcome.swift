import Vapor

extension CustomerDispute {
    
    /// The outcome of a customer dispute.
    public struct Outcome: Content, Equatable {
        
        /// The outcome code of a resolved dispute. If the value is `nil`, the dispute is not resolved.
        public var code: Code?
        
        /// The amount that either the merchant or PayPal refunds the customer.
        public var refunded: Money?
        
        /// Creates a new `CustomerDispute.Outcome` instance.
        ///
        ///     CustomerDispute.Outcome(code: .buyer, refunded: Money(currency: .usd, value: "56.72"))
        public init(code: Code?, refunded: Money?) {
            self.code = code
            self.refunded = refunded
        }
        
        enum CodingKeys: String, CodingKey {
            case code = "outcome_code"
            case refunded = "amount_refunded"
        }
    }
}
