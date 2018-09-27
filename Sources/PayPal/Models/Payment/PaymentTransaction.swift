import Vapor

extension Payment {
    public struct Transaction: Content, Equatable {
        public let resources: [RelatedResource]?
        
        public var amount: DetailedAmount?
        public var payee: Payee?
        public var description: String?
        public var payeeNote: String?
        public var custom: String?
        public var invoice: String?
        public var softDescriptor: String?
        public var payment: PaymentMethod?
        public var itemList: ItemList?
        public var notify: String?
        
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
