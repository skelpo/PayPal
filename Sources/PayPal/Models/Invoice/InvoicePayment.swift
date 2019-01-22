import Vapor

extension Invoice {
    
    /// Information used to make a payment for an invoice.
    public struct Payment: Content, Equatable {
        
        /// The payment mode or method.
        ///
        /// - Note: This property is required for making a invoice as paid.
        public var method: PaymentDetail.Method?
        
        /// The payment amount to record against the invoice. If you omit this parameter,
        /// the total invoice amount is marked as paid. This amount cannot exceed the amount due.
        public var amount: CurrencyAmount?
        
        /// The date when the invoice was paid, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public var date: ISO8601Date?
        
        /// A note associated with the payment.
        public var note: String?
        
        
        /// Creates a new `Invoice.Payment` instance.
        ///
        /// - Parameters:
        ///   - method: The payment mode or method.
        ///   - amount: The payment amount to record against the invoice.
        ///   - date: The date when the invoice was paid.
        ///   - note: A note associated with the payment.
        public init(method: PaymentDetail.Method? = nil, amount: CurrencyAmount?, date: Date?, note: String?) {
            self.method = method
            self.amount = amount
            self.date = date == nil ? nil : ISO8601Date(date!)
            self.note = note
        }
    }
}
