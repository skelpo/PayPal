import Vapor

extension Payment {
    
    /// The Request body sent to the `POST /v1/payments/payment/{payment_id}/execute` API endpoint.
    public struct Executor: Content, Equatable {
        
        /// The ID of the payer that PayPal passes in the `return_url`.
        public var payer: String?
        
        /// The `amount` objects for the transaction details.
        ///
        /// > An array of transaction details. Includes the amount and item details. For update and execute payment calls,
        /// > the transactions object accepts only the amount object.
        public var transactions: [DetailedAmount]?
        
        
        /// Creates a new `Payment.Executor` instance.
        ///
        /// - Parameters:
        ///   - payer: The ID of the payer that PayPal passes in the `return_url`.
        ///   - transactions: The `amount` objects for the transaction details.
        public init(payer: String?, transactions: [DetailedAmount]?) {
            self.payer = payer
            self.transactions = transactions
        }
    }
}
