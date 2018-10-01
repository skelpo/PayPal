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
        public var amount: Amount?
        
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
        
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Payment.RefundResult> {
            var validations = SetterValidations(Payment.RefundResult.self)
            
            validations.set(\.invoice) { invoice in
                guard invoice?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`invoice_number` value length must be 127 or less")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case id, amount, state, reason, description, links
            case invoice = "invoice_number"
            case sale = "sale_id"
            case capture = "capture_id"
            case parent = "parent_payment"
            case created = "create_time"
            case updated = "update_time"
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
