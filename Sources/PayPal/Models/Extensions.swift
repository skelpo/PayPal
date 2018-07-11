import Vapor

/// The extension properties for an `Activity` object.
public final class Extensions: Content, Equatable {
    
    /// The properties for a payment activity.
    public var paymentProperties: PaymentProperties?
    
    /// The money request activity.
    public var requestMoneyProperties: MoneyRequestProperties?
    
    /// The invoice activity properties.
    public var invoiceProperties: InvoiceProperties?
    
    /// The order activity-specific properties.
    public var orderProperties: OrderProperties?
    
    /// Creates a new `Extensions` instance.
    public init(
        paymentProperties: PaymentProperties?,
        requestMoneyProperties: MoneyRequestProperties?,
        invoiceProperties: InvoiceProperties?,
        orderProperties: OrderProperties?
    ) {
        self.paymentProperties = paymentProperties
        self.requestMoneyProperties = requestMoneyProperties
        self.invoiceProperties = invoiceProperties
        self.orderProperties = orderProperties
    }
    
    /// Compares two `Extensions` objects, checking that the `paymentProperties`, `requestMoneyProperties`,
    /// `invoiceProperties`, and `orderProperties` properties are the same
    public static func == (lhs: Extensions, rhs: Extensions) -> Bool {
        return
            (lhs.paymentProperties == rhs.paymentProperties) &&
            (lhs.requestMoneyProperties == rhs.requestMoneyProperties) &&
            (lhs.invoiceProperties == rhs.invoiceProperties) &&
            (lhs.orderProperties == rhs.orderProperties)
    }
    
    enum CodingKeys: String, CodingKey {
        case paymentProperties = "payment_properties"
        case requestMoneyProperties = "request_money_properties"
        case invoiceProperties = "invoice_properties"
        case orderProperties = "order_properties"
    }
}
