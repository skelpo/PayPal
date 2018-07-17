import Vapor

/// Additional information about an invoice activity object.
public struct InvoiceProperties: Content, Equatable {
    
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
    
    /// Compares two `InvoiceProperties` objects, checking that the `role` and `invoiceNumber` properties are the same
    public static func == (lhs: InvoiceProperties, rhs: InvoiceProperties) -> Bool {
        return (lhs.role == rhs.role) && (lhs.invoiceNumber == rhs.invoiceNumber)
    }
    
    enum CodingKeys: String, CodingKey {
        case role
        case invoiceNumber = "invoice_number"
    }
}
