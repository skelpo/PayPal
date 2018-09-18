import Vapor

extension Order {
    public struct Payment: Content, Equatable {
        public var captures: [Capture]?
        public var refunds: [Refund]?
        public var sales: [Sale]?
        public var authorizations: [Sale]?
        
        public init(captures: [Capture]?, refunds: [Refund]?, sales: [Sale]?, authorizations: [Sale]?) {
            self.captures = captures
            self.refunds = refunds
            self.sales = sales
            self.authorizations = authorizations
        }
    }
}
