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
        public var description: Optional127String
        
        /// The note to the recipient of the funds in this transaction.
        ///
        /// Maximum length: 255.
        public var payeeNote: Failable<String?, NotNilValidate<Length255>>
        
        /// The free-form field for the client's use.
        ///
        /// Maximum length: 127.
        public var custom: Optional127String
        
        /// The invoice number to track this payment.
        ///
        /// Maximum length: 127.
        public var invoice: Optional127String
        
        /// The soft descriptor to use to charge this funding source. If greater than the maximum allowed length, the API truncates the string.
        ///
        /// Maximum length: 22.
        public var softDescriptor: Failable<String?, NotNilValidate<Length22>>
        
        /// The payment options for this transaction.
        public var payment: Options?
        
        /// An array of items that are being purchased.
        public var itemList: ItemList?
        
        /// The URL to send payment notifications.
        ///
        /// Maximum length: 2048.
        public var notify: Failable<String?, NotNilValidate<Length2048>>
        
        
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
            description: Optional127String,
            payeeNote: Failable<String?, NotNilValidate<Length255>>,
            custom: Optional127String,
            invoice: Optional127String,
            softDescriptor: Failable<String?, NotNilValidate<Length22>>,
            payment: Options.Method?,
            itemList: ItemList?,
            notify: Failable<String?, NotNilValidate<Length2048>>
        ) {
            self.resources = nil
            self.amount = amount
            self.payee = payee
            self.description = description
            self.payeeNote = payeeNote
            self.custom = custom
            self.invoice = invoice
            self.softDescriptor = softDescriptor
            self.payment = Options(allowed: payment)
            self.itemList = itemList
            self.notify = notify
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
