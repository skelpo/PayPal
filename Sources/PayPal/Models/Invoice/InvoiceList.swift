import Vapor

public struct InvoiceList: Content, Equatable {
    public let count: Int?
    public let links: [LinkDescription]?
    public var invoices: [Invoice]?
    
    public init(invoices: [Invoice]?) {
        self.count = invoices?.count
        self.links = []
        self.invoices = invoices
    }
}
