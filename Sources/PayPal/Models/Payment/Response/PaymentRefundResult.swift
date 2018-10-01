import Vapor

extension Payment {
    public struct RefundResult: Content, Equatable {
        public let id: String?
        public let state: State?
        public let sale: String?
        public let capture: String?
        public let parent: String?
        public let created: String?
        public let updated: String?
        public let links: [LinkDescription]?
        
        public var amount: Amount?
        public var reason: String?
        public var invoice: String?
        public var description: String?
    }
}

extension Payment.RefundResult {
    
    /// The state of a payment refund.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// `pending`.
        case pending
        
        /// `completed`.
        case completed
        
        /// `cancelled`.
        case cancelled
        
        /// `failed`.
        case failed
    }
}
