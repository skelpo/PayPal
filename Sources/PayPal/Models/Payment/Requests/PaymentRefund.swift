import Vapor

extension Payment {
    
    /// The request body used to refund payments, on API endpoints such as `POST /v1/payments/sale/{sale_id}/refund`.
    public struct Refund: Content, ValidationSetable, Equatable {
        
        /// The refund amount. Includes both the amount to refund to the payer and the fee amount to refund to the payee.
        public var amount: DetailedAmount?
        
        /// The refund description. Value is a string of single-byte alphanumeric characters.
        ///
        /// This property can be set using the `Refund.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 255.
        public private(set) var description: String?
        
        /// The refund reason description.
        ///
        /// This property can be set using the `Refund.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 30.
        public private(set) var reason: String?
        
        /// The invoice number that tracks this payment. Value is a string of single-byte alphanumeric characters.
        ///
        /// This property can be set using the `Refund.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 127.
        public private(set) var invoice: String?
        
        
        /// Creates a new `Payment.Refund` instance.
        ///
        /// - Parameters:
        ///   - amount: The refund amount.
        ///   - description: The refund description.
        ///   - reason: The refund reason description.
        ///   - invoice: The invoice number that tracks this payment.
        public init(amount: DetailedAmount?, description: String?, reason: String?, invoice: String?)throws {
            self.amount = amount
            self.description = description
            self.reason = reason
            self.invoice = invoice
            
            try self.set(\.description <~ description)
            try self.set(\.reason <~ reason)
            try self.set(\.invoice <~ invoice)
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            try self.init(
                amount: container.decodeIfPresent(DetailedAmount.self, forKey: .amount),
                description: container.decodeIfPresent(String.self, forKey: .description),
                reason: container.decodeIfPresent(String.self, forKey: .reason),
                invoice: container.decodeIfPresent(String.self, forKey: .invoice)
            )
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Payment.Refund> {
            var validations = SetterValidations(Payment.Refund.self)
            
            validations.set(\.description) { description in
                guard description?.count ?? 0 <= 255 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`description` value length must be 255 or less")
                }
            }
            validations.set(\.reason) { reason in
                guard reason?.count ?? 0 <= 30 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`reason` value length must be 30 or less")
                }
            }
            validations.set(\.invoice) { invoice in
                guard invoice?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`invoice` value length must be 127 or less")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case amount, description, reason
            case invoice = "invoice_number"
        }
    }
}
