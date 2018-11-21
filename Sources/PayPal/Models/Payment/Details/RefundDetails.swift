import Vapor

/// The refund details of an invoice.
public struct RefundDetail: Content, Equatable {
    
    /// The refund type in an invoicing flow. The [record refund](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_record-refund)
    /// method supports the `EXTERNAL` refund type. The `PAYPAL` refund type is supported for backward compatibility.
    public let type: PaymentDetail.DetailType?
    
    /// The ID for a PayPal refund transaction. Required for the `PAYPAL` refund type.
    public let transaction: String?
    
    
    /// The date when the invoice was refunded, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public var date: String?
    
    /// A note associated with the refund.
    public var note: String?
    
    /// The currency and amount to record as refunded. If you omit the amount, the total invoice paid amount is recorded as refunded.
    public var amount: CurrencyAmount?
    
    
    /// Creates a new `RefundDetail` instance.
    ///
    ///     RefundDetail(date: Date().iso8601, note: "Hello World", amount: Amount(currency: .usd, value: "4.50"))
    public init(date: String?, note: String?, amount: CurrencyAmount?) {
        self.type = nil
        self.transaction = nil
        
        self.date = date
        self.note = note
        self.amount = amount
    }
    
    enum CodingKeys: String, CodingKey {
        case type, date, note, amount
        case transaction = "transaction_id"
    }
}

