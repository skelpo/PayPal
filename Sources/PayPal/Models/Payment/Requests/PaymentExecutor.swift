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
        public var amounts: [DetailedAmount]?
        
        
        /// Creates a new `Payment.Executor` instance.
        ///
        /// - Parameters:
        ///   - payer: The ID of the payer that PayPal passes in the `return_url`.
        ///   - amounts: The `amount` objects for the transaction details.
        public init(payer: String?, amounts: [DetailedAmount]?) {
            self.payer = payer
            self.amounts = amounts
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.payer = try container.decodeIfPresent(String.self, forKey: .payer)
        
            var transactions = try container.nestedUnkeyedContainer(forKey: .transactions)
            var amounts: [DetailedAmount] = []
            while !transactions.isAtEnd {
                let transaction = try transactions.nestedContainer(keyedBy: CodingKeys.self)
                try amounts.append(transaction.decode(DetailedAmount.self, forKey: .amount))
            }
            
            self.amounts = amounts
        }
        
        /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
        public func encode(to encoder: Encoder)throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(self.payer, forKey: .payer)
            
            var transactions = container.nestedUnkeyedContainer(forKey: .transactions)
            try self.amounts?.forEach { amount in
                var transaction = transactions.nestedContainer(keyedBy: CodingKeys.self)
                try transaction.encode(amount, forKey: .amount)
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case transactions, amount
            case payer = "payer_id"
        }
    }
}
