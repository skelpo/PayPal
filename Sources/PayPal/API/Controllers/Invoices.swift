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
    
    /// Lists invoices. To filter the invoices that appear in the response, you can specify one or more optional query parameters.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that lists invoices with details.
    ///
    /// - Parameter parameters: The query string parameters that are passed with the request in the path. The query paramaters used are
    ///   `page`, `page_size`, and `total_count_required`.
    ///
    /// - Returns: The list of invoices that match the query parameters passed in. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func list(parameters: QueryParamaters = QueryParamaters()) -> Future<InvoiceList> {
        return Future.flatMap(on: self.container) { () -> EventLoopFuture<InvoiceList> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path(), parameters: parameters, as: InvoiceList.self)
        }
    }
    
    /// Fully updates an invoice, by ID. In the JSON request body, include a complete `invoice` object. This call does not support partial updates.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows invoice details.
    ///
    /// - Parameters:
    ///   - id: The ID of the invoice to update.
    ///   - body: The new data for the specified invoice.
    ///   - notify: Indicates whether to send the invoice update notification to the merchant.
    ///
    /// - Returns: The updated invoice object. If an error response was sent back instead, it gets converted to a Swift error and the future wraps that instead.
    public func update(invoice id: String, with body: Invoice, notifyMerchant notify: Bool = true) -> Future<Invoice> {
        return Future.flatMap(on: self.container) { () -> EventLoopFuture<Invoice> in
            let client = try self.container.make(PayPalClient.self)
            return try client.put(self.path() + id, parameters: QueryParamaters(custom: ["notify_merchant": notify.description]), body: body, as: Invoice.self)
        }
    }
    
    /// Shows details for an invoice, by ID.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows invoice details.
    ///
    /// - Parameter invoiceID: The ID of the invoice for which to show details.
    ///
    /// - Returns: The invoice data for the ID passed in. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func details(for invoiceID: String) -> Future<Invoice> {
        return Future.flatMap(on: self.container) { () -> Future<Invoice> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path() + invoiceID, as: Invoice.self)
        }
    }
    
    /// Deletes invoices in the `DRAFT` or `SCHEDULED` state, by ID. For invoices that have already been sent,
    /// you can [cancel the invoice](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_cancel). After you delete a draft or scheduled invoice,
    /// you can no longer use it or show its details. However, you can reuse its invoice number.
    ///
    /// A successful request returns the HTTP `204 No Content` status code with no JSON response body.
    ///
    /// - Parameter id: The ID of the draft invoice to delete.
    ///
    /// - Returns: The HTTP status of the response, which will be 204 (No Content). If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func delete(invoice id: String) -> Future<HTTPStatus> {
        return Future.flatMap(on: self.container) { () -> Future<HTTPStatus> in
            let client = try self.container.make(PayPalClient.self)
            return try client.delete(self.path() + id, as: HTTPStatus.self)
        }
    }
}
