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
        public var date: String?
        
        /// A note associated with the payment.
        public var note: String?
        
        
        /// Creates a new `Invoice.Payment` instance.
        ///
        ///     Invoice.Payment(method: .cash, amount: Amount(currency: .usd, value: "20.00"), date: Date().iso8601, note: "I got the payment by cash!")
        public init(method: PaymentDetail.Method? = nil, amount: CurrencyAmount?, date: String?, note: String?) {
            self.method = method
            self.amount = amount
            self.date = date
            self.note = note
        }
    }
}
