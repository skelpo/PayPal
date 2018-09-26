import Vapor

extension RelatedResource {
    public struct Refund: Content, Equatable {
        public let id: String?
        public let state: State?
        public let sale: String?
        public let capture: String?
        public let payment: String?
        public let created: String?
        public let updated: String?
        public let links: [LinkDescription]?
        
        public var amount: DetailedAmount?
        public var reason: String?
        public var invoice: String?
        public var description: String?
        
        public init(amount: DetailedAmount?, reason: String?, invoice: String?, description: String?) {
            self.id = nil
            self.state = nil
            self.sale = nil
            self.capture = nil
            self.payment = nil
            self.created = nil
            self.updated = nil
            self.links = nil
            
            self.amount = amount
            self.reason = reason
            self.invoice = invoice
            self.description = description
        }
    }
}

extension RelatedResource.Refund {
    
    /// The state of a refund transaction. 
    public enum State: String, Hashable, CaseIterable, Content {
        
        ///  The refund state is pending.
        case pending
        
        ///  The refund state is completed.
        case completed
        
        ///  The refund state is cancelled.
        case cancelled
        
        ///  The refund state is failed.
        case failed
    }
}
