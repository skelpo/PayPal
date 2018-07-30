import Vapor

/// Evidence used during a dispute.
public struct Evidence: Content, Equatable {
    
    /// An array of relevant tracking information for the transaction involved in this dispute.
    public var tracking: [Tracking]?
    
    /// An array of refund IDs for the transaction involved in this dispute.
    public var refunds: [String]?
    
    /// Creates a new `Evidence` instance.
    ///
    ///     Evidence(
    ///         tracking: [
    ///             Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
    ///         ],
    ///         refunds: [
    ///             "2F214F48-2651-498B-9D06-150BF00E85DA"
    ///         ]
    ///     )
    public init(tracking: [Tracking]?, refunds: [String]?) {
        self.tracking = tracking
        self.refunds = refunds
    }
}
