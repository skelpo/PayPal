import Vapor

extension Order {
    
    /// The payment summary or a purchase unit in an order.
    public struct Payment: Content, Equatable {
        
        /// An array of captures for a purchase unit. A purchase unit can have zero or more captures.
        public var captures: [Capture]?
        
        /// An array of refunds for a purchase unit. A purchase unit can have zero or more refunds.
        public var refunds: [Refund]?
        
        /// An array of sales for a purchase unit. A purchase unit can have zero or more sales.
        public var sales: [Sale]?
        
        /// An array of authorizations for a purchase unit. A purchase unit can have zero or more authorizations.
        public var authorizations: [Sale]?
        
        
        /// Creates a new `Order.Payment` instance.
        ///
        /// - Parameters:
        ///   - captures: An array of captures for a purchase unit.
        ///   - refunds: An array of refunds for a purchase unit.
        ///   - sales: An array of sales for a purchase unit.
        ///   - authorizations: An array of authorizations for a purchase unit.
        public init(captures: [Capture]?, refunds: [Refund]?, sales: [Sale]?, authorizations: [Sale]?) {
            self.captures = captures
            self.refunds = refunds
            self.sales = sales
            self.authorizations = authorizations
        }
    }
}
