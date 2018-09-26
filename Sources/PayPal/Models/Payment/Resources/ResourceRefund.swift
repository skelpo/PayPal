import Vapor

extension RelatedResource {
    
    /// The refund details for a transaction.
    public struct Refund: Content, ValidationSetable, Equatable {
        
        /// The ID of the refund transaction. Maximum length is 17 characters.
        public let id: String?
        
        /// The state of the refund.
        public let state: State?
        
        /// The ID of the sale transaction being refunded.
        public let sale: String?
        
        /// The ID of the sale transaction being refunded.
        public let capture: String?
        
        /// The ID of the payment on which this transaction is based.
        public let payment: String?
        
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
        /// This property can be set using the `Refund.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 127.
        public private(set) var invoice: String?
        
        /// The refund description. Value must be single-byte alphanumeric characters.
        public var description: String?
        
        
        /// Created a new `RelatedResource.Refund` instance.
        ///
        /// - Parameters:
        ///   - amount: The refund amount.
        ///   - reason: The reason that the transaction is being refunded.
        ///   - invoice: The invoice or tracking ID number.
        ///   - description: The refund description.
        public init(amount: DetailedAmount?, reason: String?, invoice: String?, description: String?)throws {
            self.id = nil
            self.state = nil
            self.sale = nil
            self.capture = nil
            self.payment = nil
            self.created = nil
            self.updated = nil
            self.links = nil
            
            self.amount = amount
            self.reason = reason
            self.invoice = invoice
            self.description = description
            
            try self.set(\.invoice <~ invoice)
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decodeIfPresent(String.self, forKey: .id)
            self.state = try container.decodeIfPresent(State.self, forKey: .state)
            self.sale = try container.decodeIfPresent(String.self, forKey: .sale)
            self.capture = try container.decodeIfPresent(String.self, forKey: .capture)
            self.payment = try container.decodeIfPresent(String.self, forKey: .payment)
            self.created = try container.decodeIfPresent(String.self, forKey: .created)
            self.updated = try container.decodeIfPresent(String.self, forKey: .updated)
            self.links = try container.decodeIfPresent([LinkDescription].self, forKey: .links)
            self.amount = try container.decodeIfPresent(DetailedAmount.self, forKey: .amount)
            self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
            self.invoice = try container.decodeIfPresent(String.self, forKey: .invoice)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            
            try self.set(\.invoice <~ invoice)
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<RelatedResource.Refund> {
            var validations = SetterValidations(RelatedResource.Refund.self)
            
            validations.set(\.invoice) { invoice in
                guard invoice?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`invoice` value must have a length of 127 or less")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case id, state, links, amount, reason, description
            case sale = "sale_id"
            case capture = "capture_id"
            case payment = "parent_payment"
            case created = "create_time"
            case updated = "update_time"
            case invoice = "invoice_number"
        }
    }
}

extension RelatedResource.Refund {
    
    /// The state of a refund transaction. 
    public enum State: String, Hashable, CaseIterable, Content {
        
        ///  The refund state is pending.
        case pending
        
        ///  The refund state is completed.
        case completed
        
        ///  The refund state is cancelled.
        case cancelled
        
        ///  The refund state is failed.
        case failed
    }
}
