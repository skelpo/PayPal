import Vapor

/// The payment details of an invoice.
public struct PaymentDetail: Content, Equatable {
    
    /// The payment type in an invoicing flow. The [record refund](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_record-refund)
    /// method supports the `EXTERNAL` refund type. The `PAYPAL` refund type is supported for backward compatibility.
    public let type: DetailType?
    
    /// The ID for a PayPal payment transaction. Required for the `PAYPAL` payment type.
    public let transaction: String?
    
    /// The transaction type.
    public let transactionType: TransactionType?
    
    
    /// The date when the invoice was paid, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public var date: ISO8601Date?
    
    /// The payment mode or method.
    public var method: Method
    
    /// A note associated with the payment.
    public var note: String?
    
    /// The payment amount to record against the invoice. If you omit this parameter,
    /// the total invoice amount is marked as paid. This amount cannot exceed the amount due.
    public var amount: CurrencyAmount?
    
    
    /// Creates a new `PaymentDetail` instance.
    ///
    /// - Parameters:
    ///   - date: The date when the invoice was paid.
    ///   - method: The payment mode or method.
    ///   - note: A note associated with the payment.
    ///   - amount: The payment amount to record against the invoice.
    public init(date: Date?, method: Method, note: String?, amount: CurrencyAmount?) {
        self.type = nil
        self.transaction = nil
        self.transactionType = nil
        
        self.date = date == nil ? nil : ISO8601Date(date!)
        self.method = method
        self.note = note
        self.amount = amount
    }
    
    enum CodingKeys: String, CodingKey {
        case type, date, method, note, amount
        case transaction = "transaction_id"
        case transactionType = "transaction_type"
    }
}
