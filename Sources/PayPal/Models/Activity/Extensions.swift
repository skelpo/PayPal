import Vapor

/// The extension properties for an `Activity` object.
public final class Extensions: Content {
    
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
}
