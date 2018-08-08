import Vapor

public struct Discount<M>: Content, Equatable where M: Monitary {
    public var percent: Decimal?
    public var amount: M?
    
    public init(percent: Decimal?, amount: M?) {
        self.percent = percent
        self.amount = amount
    }
}
