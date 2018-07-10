import Vapor

/// Additional information about an invoice activity object.
public final class InvoiceProperties: Content {
    
    /// The invoice role.
    public var role: Role?
    
    /// The merchant-provided invoice number for the transaction.
    public var invoiceNumber: String?
    
    /// Creates a new `InvoicProperties` instance
    ///
    ///     InvoiceProperties(role: .payee, invoiceNumber: "<something-here>")
    public init(role: Role?, invoiceNumber: String?) {
        self.role = role
        self.invoiceNumber = invoiceNumber
    }
    
    enum CodingKeys: String, CodingKey {
        case role
        case invoiceNumber = "invoice_number"
    }
}
