import Vapor

public struct FundingInstrument: Content, Equatable {
    public var token: CreditCard.Token?
    
    public init(token: CreditCard.Token?) {
        self.token = token
    }
}
