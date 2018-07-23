import Vapor

public struct Transaction: Content, Equatable {
    public let id: String?
    public let state: State?
    public let type: String?
    public let email: String?
    public let name: String?
    public let timestamp: String?
    public let timezone: String?
    
    public var amount: Money
    public var fee: Money
    public var net: Money
    
    public init(amount: Money, fee: Money, net: Money) {
        self.id = nil
        self.state = nil
        self.type = nil
        self.email = nil
        self.name = nil
        self.timestamp = nil
        self.timezone = nil
        
        self.amount = amount
        self.fee = fee
        self.net = net
    }
}
