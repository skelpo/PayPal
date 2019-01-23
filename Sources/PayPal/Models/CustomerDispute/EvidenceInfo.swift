import Vapor

extension Evidence {
    
    /// Evidence.Info used during a dispute.
    public struct Info: Content, Equatable {
        
        /// An array of relevant tracking information for the transaction involved in this dispute.
        public var tracking: [Tracking]?
        
        /// An array of refund IDs for the transaction involved in this dispute.
        public var refunds: [String]?
        
        /// Creates a new `Evidence.Info` instance.
        ///
        /// - Parameters:
        ///   - tracking: An array of relevant tracking information for the transaction involved in this dispute.
        ///   - refunds: An array of refund IDs for the transaction involved in this dispute.
        public init(tracking: [Tracking]?, refunds: [String]?) {
            self.tracking = tracking
            self.refunds = refunds
        }
        
        enum CodingKeys: String, CodingKey {
            case tracking = "tracking_info"
            case refunds = "refund_ids"
        }
    }
}
