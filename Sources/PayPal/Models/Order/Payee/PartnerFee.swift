import Vapor

public struct PartnerFee: Content, Equatable {
    public var receiver: Payee
    public var amount: Amount
    
    public init(receiver: Payee, amount: Amount) {
        self.receiver = receiver
        self.amount = amount
    }
}
