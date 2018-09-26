import Vapor

public struct RelatedResource: Content, Equatable {
    public var sale: Sale?
    public var authorization: Authorization?
    public var order: Order?
    public var capture: Capture?
    public var refund: Refund?
    
    public init(sale: Sale?, authorization: Authorization?, order: Order?, capture: Capture?, refund: Refund?) {
        self.sale = sale
        self.authorization = authorization
        self.order = order
        self.capture = capture
        self.refund = refund
    }
}
