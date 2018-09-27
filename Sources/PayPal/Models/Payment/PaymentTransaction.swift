import Vapor

extension Payment {
    
    /// A definition of what the payment is for and who will fulfill the payment.
    public struct Transaction: Content, Equatable {
        
        /// An array of payment-related transactions. A transaction defines what the payment is for and who fulfills the payment.
        public let resources: [RelatedResource]?
        
        
        /// The amount to collect.
        public var amount: DetailedAmount?
        
        /// The payee who receives the funds and fulfills the order.
        public var payee: Payee?
        
        /// The purchase description.
        ///
        /// Maximum length: 127.
        public var description: String?
        
        /// The note to the recipient of the funds in this transaction.
        ///
        /// Maximum length: 255.
        public var payeeNote: String?
        
        /// The free-form field for the client's use.
        ///
        /// Maximum length: 127.
        public var custom: String?
        
        /// The invoice number to track this payment.
        ///
        /// Maximum length: 127.
        public var invoice: String?
        
        /// The soft descriptor to use to charge this funding source. If greater than the maximum allowed length, the API truncates the string.
        ///
        /// Maximum length: 22.
        public var softDescriptor: String?
        
        /// The payment options for this transaction.
        public var payment: PaymentMethod?
        
        /// An array of items that are being purchased.
        public var itemList: ItemList?
        
        /// The URL to send payment notifications.
        ///
        /// Maximum length: 2048.
        public var notify: String?
        
        
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
        ) {
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
