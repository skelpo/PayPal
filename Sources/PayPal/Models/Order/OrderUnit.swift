import Vapor

extension Order {
    
    /// A purchase unit which establishes a contract between a customer and merchant.
    public struct Unit: Content, ValidationSetable, Equatable {
        
        /// The transaction state.
        public let status: Status?
        
        /// The reason code for a transaction status of `PENDING` or `REVERSED`. Eventually,
        /// this field will replace `pending_reason`. Supported only for the PayPal payment method.
        public let reason: Reason?
        
        
        /// The merchant ID for the purchase unit.
        ///
        /// Maximum length: 256.
        public var reference: String
        
        /// The amount to collect.
        public var amount: DetailedAmount
        
        /// The recipient of the funds for this transaction.
        public var payee: Payee?
        
        /// The purchase description.
        ///
        /// Maximum length: 127.
        public var description: String?
        
        /// The client-provided external ID. Used to reconcile client transactions with PayPal transactions.
        /// Returned in transaction and settlement reports. Only supported for the PayPal payment method.
        ///
        /// Maximum length: 127.
        public var invoice: String?
        
        /// The API caller-provided external invoice ID for this order. Only supported for the PayPal payment method.
        ///
        /// Maximum length: 256.
        public var custom: String?
        
        /// The payment descriptor on the buyer credit card statement of account activity.
        ///
        /// Maximum length: 22.
        public var paymentDescriptor: String?
        
        /// An array of items that the customer is purchasing from the merchant.
        public var items: [Item]?
        
        /// The payment notifications URL.
        ///
        /// Maximum length: 2048.
        public var notify: String?
        
        /// The shipping address details.
        public var shippingAddress: Address?
        
        /// The shipping method. For example, `USPSParcel`.
        public var shippingMethod: String?
        
        /// The partner fee that is collected for the original transaction.
        public var partnerFee: PartnerFee?
        
        /// An ID that groups multiple linked purchase units. The purchase transactions are linked only for the payment and not for refund.
        /// A refund is processed only for the specific transaction within the same linked group.
        ///
        /// Minimum value: 1. Maximum value: 100.
        public var paymentGroup: Int?
        
        /// The name-and-value pairs that contain external data, such as user, user feedback, score, and so on.
        public var metadata: Metadata?
        
        /// The payment summary.
        public var payment: Payment?
        
        
        /// Creates a new `Order.Unit` instance.
        ///
        /// - Parameters:
        ///   - reference: The merchant ID for the purchase unit.
        ///   - amount: The amount to collect.
        ///   - payee: The recipient of the funds for this transaction.
        ///   - description: The purchase description.
        ///   - invoice: The client-provided external ID.
        ///   - custom: The API caller-provided external invoice ID for this order.
        ///   - paymentDescriptor: The payment descriptor on the buyer credit card statement of account activity.
        ///   - items: An array of items that the customer is purchasing from the merchant.
        ///   - notify: The payment notifications URL.
        ///   - shippingAddress: The shipping address details.
        ///   - shippingMethod: The shipping method.
        ///   - partnerFee: The partner fee that is collected for the original transaction.
        ///   - paymentGroup: An ID that groups multiple linked purchase units.
        ///   - metadata: The name-and-value pairs that contain external data.
        ///   - payment: The payment summary.
        public init(
            reference: String,
            amount: DetailedAmount,
            payee: Payee?,
            description: String?,
            invoice: String?,
            custom: String?,
            paymentDescriptor: String?,
            items: [Item]?,
            notify: String?,
            shippingAddress: Address?,
            shippingMethod: String?,
            partnerFee: PartnerFee?,
            paymentGroup: Int?,
            metadata: Metadata?,
            payment: Payment?
        )throws {
            self.status = nil
            self.reason = nil
            self.reference = reference
            self.amount = amount
            self.payee = payee
            self.description = description
            self.invoice = invoice
            self.custom = custom
            self.paymentDescriptor = paymentDescriptor
            self.items = items
            self.notify = notify
            self.shippingAddress = shippingAddress
            self.shippingMethod = shippingMethod
            self.partnerFee = partnerFee
            self.paymentGroup = paymentGroup
            self.metadata = metadata
            self.payment = payment
            
            try self.set(\.reference <~ reference)
            try self.set(\.description <~ description)
            try self.set(\.custom <~ custom)
            try self.set(\.invoice <~ invoice)
            try self.set(\.paymentDescriptor <~ paymentDescriptor)
            try self.set(\.notify <~ notify)
            try self.set(\.paymentGroup <~ paymentGroup)
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.status = try container.decodeIfPresent(Status.self, forKey: .status)
            self.reason = try container.decodeIfPresent(Reason.self, forKey: .reason)
            self.reference = try container.decode(String.self, forKey: .reference)
            self.amount = try container.decode(DetailedAmount.self, forKey: .amount)
            self.payee = try container.decodeIfPresent(Payee.self, forKey: .payee)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.invoice = try container.decodeIfPresent(String.self, forKey: .invoice)
            self.custom = try container.decodeIfPresent(String.self, forKey: .custom)
            self.paymentDescriptor = try container.decodeIfPresent(String.self, forKey: .paymentDescriptor)
            self.items = try container.decodeIfPresent([Item].self, forKey: .items)
            self.notify = try container.decodeIfPresent(String.self, forKey: .notify)
            self.shippingAddress = try container.decodeIfPresent(Address.self, forKey: .shippingAddress)
            self.shippingMethod = try container.decodeIfPresent(String.self, forKey: .shippingMethod)
            self.partnerFee = try container.decodeIfPresent(PartnerFee.self, forKey: .partnerFee)
            self.paymentGroup = try container.decodeIfPresent(Int.self, forKey: .paymentGroup)
            self.metadata = try container.decodeIfPresent(Metadata.self, forKey: .metadata)
            self.payment = try container.decodeIfPresent(Payment.self, forKey: .payment)
            
            try self.set(\.reference <~ reference)
            try self.set(\.description <~ description)
            try self.set(\.custom <~ custom)
            try self.set(\.invoice <~ invoice)
            try self.set(\.paymentDescriptor <~ paymentDescriptor)
            try self.set(\.notify <~ notify)
            try self.set(\.paymentGroup <~ paymentGroup)
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Order.Unit> {
            var validations = SetterValidations(Order.Unit.self)
            
            validations.set(\.reference) { reference in
                guard reference.count <= 256 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`reference` value length must be 256 or less.")
                }
            }
            validations.set(\.description) { description in
                guard description?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`description` value length must be 127 or less.")
                }
            }
            validations.set(\.custom) { custom in
                guard custom?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`custom` value length must be 127 or less.")
                }
            }
            validations.set(\.invoice) { invoice in
                guard invoice?.count ?? 0 <= 256 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`invoice` value length must be 256 or less.")
                }
            }
            validations.set(\.paymentDescriptor) { paymentDescriptor in
                guard paymentDescriptor?.count ?? 0 <= 22 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`paymentDescriptor` value length must be 22 or less.")
                }
            }
            validations.set(\.notify) { notify in
                guard notify?.count ?? 0 <= 2048 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`notify` value length must be 2048 or less.")
                }
            }
            validations.set(\.paymentGroup) { paymentGroup in
                guard (1...100).contains(paymentGroup ?? 1) else {
                    throw PayPalError(status: .badRequest, identifier: "invalidInt", reason: "`paymentGroup` value must be in range 1...100 or `nil`")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case status, amount, payee, description, custom, items, metadata
            case reference = "reference_id"
            case invoice = "invoice_number"
            case paymentDescriptor = "payment_descriptor"
            case notify = "notify_url"
            case shippingAddress = "shipping_address"
            case shippingMethod = "shipping_method"
            case partnerFee = "partner_fee_details"
            case paymentGroup = "payment_linked_group"
            case payment = "payment_summary"
            case reason = "reason_code"
        }
    }
}

extension Order.Unit {
    
    /// The transaction state of a purchase unit.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The transaction was not processed.
        case notProcessed = "NOT_PROCESSED"
        
        /// The transaction is pending.
        case pending = "PENDING"
        
        /// The transaction was declined and voided.
        case voided = "VOIDED"
        
        /// Payment for the transaction was not authorized.
        case authorized = "AUTHORIZED"
        
        /// Payment for the transaction was captured or is pending capture.
        case captured = "CAPTURED"
    }
}

extension Order.Unit {
    
    /// The reason code for a transaction status of `PENDING` or `REVERSED`. 
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// The transaction state is `PENDING` or `REVERSED` due to an unconfirmed payer shipping address.
        case unconfirmedAddress = "PAYER_SHIPPING_UNCONFIRMED"
        
        /// The transaction state is `PENDING` or `REVERSED` because it is a multi-currency transaction.
        case multiCurrency = "MULTI_CURRENCY"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a risk review.
        case risk = "RISK_REVIEW"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a regulatory review.
        case regulatory = "REGULATORY_REVIEW"
        
        /// The transaction state is `PENDING` or `REVERSED` because verification is required.
        case verification = "VERIFICATION_REQUIRED"
        
        /// The transaction state is `PENDING` or `REVERSED` because the transaction is an order.
        case order = "ORDER"
        
        /// The transaction state is `PENDING` or `REVERSED` due to another reason.
        case other = "OTHER"
        
        /// The transaction state is `PENDING` or `REVERSED` because it was declined by a policy.
        case declinedByPolicy = "DECLINED_BY_POLICY"
    }
}
