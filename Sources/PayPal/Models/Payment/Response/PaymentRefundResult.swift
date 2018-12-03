import Vapor

extension Payment {
    
    /// The response object returned when refunding payments, from API endpoints such as `POST /v1/payments/refund/{refund_id}`.
    public struct RefundResult: Content, ValidationSetable, Equatable {
        
        /// The ID of the refund transaction. Maximum length is 17 characters.
        public let id: String?
        
        /// The state of the refund.
        public let state: State?
        
        /// The ID of the sale transaction being refunded.
        public let sale: String?
        
        /// The ID of the sale transaction being refunded.
        public let capture: String?
        
        /// The ID of the payment on which this transaction is based.
        public let parent: String?
        
        /// The date and time when the refund was created, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let created: String?
        
        /// The date and time when the resource was last updated, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let updated: String?
        
        /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
        public let links: [LinkDescription]?
        
        
        /// The refund amount. Includes both the amount refunded to the payer and amount of the fee refunded to the payee.
        public var amount: DetailedAmount?
        
        /// The reason that the transaction is being refunded.
        public var reason: String?
        
        /// The invoice or tracking ID number.
        ///
        /// This property can be set using the `RefundResult.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 127.
        public private(set) var invoice: String?
        
        /// The refund description. Value must be single-byte alphanumeric characters.
        public var description: String?
        
        /// The note to the payer in this transaction.
        ///
        /// Maximum length: 127.
        public var custom: String?
        
        /// The currency and amount of the transaction fee that is refunded to original the recipient of payment.
        public var transactionFee: CurrencyAmount?
        
        /// The currency and amount of the refund that is subtracted from the original payment recipient's PayPal balance.
        public var received: CurrencyAmount?
        
        /// The currency and amount of the total refund from the original purchase.
        ///
        /// As an example, if a payer makes $100 purchase and the payer was refunded $20 a week ago and $30 in this transaction,
        /// the gross refund amount is $30 for this transaction and the total refunded amount is $50.
        public var total: CurrencyAmount?
        
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Payment.RefundResult> {
            var validations = SetterValidations(Payment.RefundResult.self)
            
            validations.set(\.invoice) { invoice in
                guard invoice?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`invoice_number` value length must be 127 or less")
                }
            }
            validations.set(\.custom) { custom in
                guard custom?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`custom` value length must be 127 or less")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case id, amount, state, reason, description, links, custom
            case invoice = "invoice_number"
            case sale = "sale_id"
            case capture = "capture_id"
            case parent = "parent_payment"
            case created = "create_time"
            case updated = "update_time"
            case transactionFee = "refund_from_transaction_fee"
            case received = "refund_from_received_amount"
            case total = "total_refunded_amount"
        }
    }
}

extension Payment.RefundResult {
    
    /// The state of a payment refund.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// `pending`.
        case pending
        
        /// `completed`.
        case completed
        
        /// `cancelled`.
        case cancelled
        
        /// `failed`.
        case failed
    }
}
