import Vapor

extension Payment {
    
    /// A definition of what the payment is for and who will fulfill the payment.
    public struct Transaction: Content, ValidationSetable, Equatable {
        
        /// An array of payment-related transactions. A transaction defines what the payment is for and who fulfills the payment.
        public let resources: [RelatedResource]?
        
        
        /// The amount to collect.
        public var amount: DetailedAmount?
        
        /// The payee who receives the funds and fulfills the order.
        public var payee: Payee?
        
        /// The purchase description.
        ///
        /// This property can be set using the `Transaction.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 127.
        public private(set) var description: String?
        
        /// The note to the recipient of the funds in this transaction.
        ///
        /// This property can be set using the `Transaction.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 255.
        public private(set) var payeeNote: String?
        
        /// The free-form field for the client's use.
        ///
        /// This property can be set using the `Transaction.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 127.
        public private(set) var custom: String?
        
        /// The invoice number to track this payment.
        ///
        /// This property can be set using the `Transaction.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 127.
        public private(set) var invoice: String?
        
        /// The soft descriptor to use to charge this funding source. If greater than the maximum allowed length, the API truncates the string.
        ///
        /// This property can be set using the `Transaction.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 22.
        public private(set) var softDescriptor: String?
        
        /// The payment options for this transaction.
        public var payment: PaymentMethod?
        
        /// An array of items that are being purchased.
        public var itemList: ItemList?
        
        /// The URL to send payment notifications.
        ///
        /// This property can be set using the `Transaction.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 2048.
        public private(set) var notify: String?
        
        
        /// Creates a new `Payment.Transaction` instance.
        ///
        /// - Parameters:
        ///   - amount: The amount to collect.
        ///   - payee: The payee who receives the funds and fulfills the order.
        ///   - description: The purchase description.
        ///   - payeeNote: The note to the recipient of the funds in this transaction.
        ///   - custom: The free-form field for the client's use.
        ///   - invoice: The invoice number to track this payment.
        ///   - softDescriptor: The soft descriptor to use to charge this funding source.
        ///   - payment: The payment options for this transaction.
        ///   - itemList: An array of items that are being purchased.
        ///   - notify: The URL to send payment notifications.
        public init(
            amount: DetailedAmount?,
            payee: Payee?,
            description: String?,
            payeeNote: String?,
            custom: String?,
            invoice: String?,
            softDescriptor: String?,
            payment: PaymentMethod?,
            itemList: ItemList?,
            notify: String?
        )throws {
            self.resources = nil
            self.amount = amount
            self.payee = payee
            self.description = description
            self.payeeNote = payeeNote
            self.custom = custom
            self.invoice = invoice
            self.softDescriptor = softDescriptor
            self.payment = payment
            self.itemList = itemList
            self.notify = notify
            
            try self.set(\.description <~ description)
            try self.set(\.payeeNote <~ payeeNote)
            try self.set(\.custom <~ custom)
            try self.set(\.invoice <~ invoice)
            try self.set(\.softDescriptor <~ softDescriptor)
            try self.set(\.notify <~ notify)
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.resources = try container.decodeIfPresent([RelatedResource].self, forKey: .resources)
            self.amount = try container.decodeIfPresent(DetailedAmount.self, forKey: .amount)
            self.payee = try container.decodeIfPresent(Payee.self, forKey: .payee)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.payeeNote = try container.decodeIfPresent(String.self, forKey: .payeeNote)
            self.custom = try container.decodeIfPresent(String.self, forKey: .custom)
            self.invoice = try container.decodeIfPresent(String.self, forKey: .invoice)
            self.softDescriptor = try container.decodeIfPresent(String.self, forKey: .softDescriptor)
            self.payment = try container.decodeIfPresent(PaymentMethod.self, forKey: .payment)
            self.itemList = try container.decodeIfPresent(ItemList.self, forKey: .itemList)
            self.notify = try container.decodeIfPresent(String.self, forKey: .notify)
            
            try self.set(\.description <~ description)
            try self.set(\.payeeNote <~ payeeNote)
            try self.set(\.custom <~ custom)
            try self.set(\.invoice <~ invoice)
            try self.set(\.softDescriptor <~ softDescriptor)
            try self.set(\.notify <~ notify)
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Payment.Transaction> {
            var validations = SetterValidations(Payment.Transaction.self)
            
            validations.set(\.description) { description in
                guard description?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`description` value length must be 127 or less")
                }
            }
            validations.set(\.payeeNote) { note in
                guard note?.count ?? 0 <= 255 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`note_to_payee` value length must be 127 or less")
                }
            }
            validations.set(\.custom) { custom in
                guard custom?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`custom` value length must be 127 or less")
                }
            }
            validations.set(\.invoice) { invoice in
                guard invoice?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`invoice_number` value length must be 127 or less")
                }
            }
            validations.set(\.softDescriptor) { softDescriptor in
                guard softDescriptor?.count ?? 0 <= 22 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`soft_descriptor` value length must be 22 or less")
                }
            }
            validations.set(\.notify) { notify in
                guard notify?.count ?? 0 <= 2048 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`notify_url` value length must be 2048 or less")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case amount, payee, description, custom
            case payeeNote = "note_to_payee"
            case invoice = "invoice_number"
            case softDescriptor = "soft_descriptor"
            case payment = "payment_options"
            case itemList = "item_list"
            case notify = "notify_url"
            case resources = "related_resources"
        }
    }
}

extension Payment.Transaction {
    
    /// The payment methods for a transaction.
    public enum PaymentMethod: String, Hashable, CaseIterable, Content {
        
        /// Merchant does not have a preference on how they want the customer to pay.
        case unrestricted = "UNRESTRICTED"
        
        /// Merchant requires that the customer pays with an instant funding source, such as a credit card or PayPal balance.
        /// All payments are processed instantly. However, payments that require a manual review are marked as pending.
        /// Merchants must handle the pending state as if the payment is not yet complete.
        case instantFunding = "INSTANT_FUNDING_SOURCE"
        
        /// Processes all payments immediately. Any payment that requires a manual review is marked failed.case
        case immediate = "IMMEDIATE_PAY"
    }
}
