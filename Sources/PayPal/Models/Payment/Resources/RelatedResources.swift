import Vapor

/// Defines what a payment is for and who fulfills the payment.
public struct RelatedResource: Content, Equatable {
    
    /// The sale transaction details.
    public var sale: Sale?
    
    /// The authorization details.
    public var authorization: Authorization?
    
    /// The order transaction details.
    public var order: Order?
    
    /// The capture transaction details.
    public var capture: Capture?
    
    /// The refund details.
    public var refund: Refund?
    
    
    /// Creates a new `RelatedResource` instance.
    ///
    /// - Parameters:
    ///   - sale: The sale transaction details.
    ///   - authorization: The authorization details.
    ///   - order: The order transaction details.
    ///   - capture: The capture transaction details.
    ///   - refund: The refund details.
    public init(sale: Sale?, authorization: Authorization?, order: Order?, capture: Capture?, refund: Refund?) {
        self.sale = sale
        self.authorization = authorization
        self.order = order
        self.capture = capture
        self.refund = refund
    }
}
