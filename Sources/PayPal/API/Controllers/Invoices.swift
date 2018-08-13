import Vapor

/// Use the `/invoices` resource to create, update, and send invoices and invoice reminders. To manage invoices, you can also list invoices,
/// show details for invoices, delete draft invoices, and cancel sent invoices. You can also mark invoices as fully or partially paid, or as refunded.
/// Lastly, you can create QR codes for invoices that can be scanned, viewed, and paid by a mobile phone.
public class Invoices: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"invoicing/invoices"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public required init(container: Container) {
        self.container = container
        self.resource = "invoicing/invoices"
    }
    
    /// Creates a draft invoice. To move the invoice from a draft to payable state,
    /// you must [send the invoice](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_send).
    ///
    /// In the JSON request body, include invoice details including merchant information. The `invoice` object must include an `items` array.
    ///
    /// A successful request returns the HTTP `201 Created` status code and a JSON response body that shows invoice details.
    ///
    /// - Note: The merchant that you specify in an invoice must have a PayPal account in good standing.
    ///
    /// - Parameter invoice: The invoice data to save as a new invoice.
    ///
    /// - Returns: The saved Invoice. If an error response was sent back instead, it gets converted to a Swift error and the future wraps that instead.
    public func create(invoice: Invoice) -> Future<Invoice> {
        return Future.flatMap(on: self.container) { () -> EventLoopFuture<Invoice> in
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path(), body: invoice, as: Invoice.self)
        }
    }
}
