import Vapor

public struct AcceptDisputeBody: Content, Equatable {
    public var note: String?
    public var reason: Reason?
    public var invoiceID: String?
    public var returnAddress: Address?
    public var refund: Money?
    
    public init(note: String?, reason: Reason?, invoiceID: String?, returnAddress: Address?, refund: Money?) {
        self.note = note
        self.reason = reason
        self.invoiceID = invoiceID
        self.returnAddress = returnAddress
        self.refund = refund
    }
}
