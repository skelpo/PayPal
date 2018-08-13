import Vapor

/// A list of invoices that makes the response for the `GET /v1/invoicing/invoices` endpoint.
public struct InvoiceList: Content, Equatable {
    
    /// The total number of invoices that match the search criteria.
    public let count: Int?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    /// An array of invoice-level details.
    ///
    /// - Note: This array does not return item details for the invoice.
    public var invoices: [Invoice]?
    
    /// Creates a new `InvoiceList` instance.
    ///
    ///     InvoiceList(invoices: [])
    public init(invoices: [Invoice]?) {
        self.count = invoices?.count
        self.links = []
        self.invoices = invoices
    }
    
    enum CodingKeys: String, CodingKey {
        case links, invoices
        case count = "total_count"
    }
}
