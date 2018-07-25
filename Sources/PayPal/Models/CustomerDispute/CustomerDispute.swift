import Vapor

public struct CustomerDispute: Content, Equatable {
    public let id: String?
    public let created: String?
    public let updated: String?
    public let status: Status?
    public let outcome: Outcome?
    public let lifecycleStage: LifeCycleStage?
    public let channel: Channel?
    public let offer: Offer?
    public let links: [LinkDescription]?
    
    public var transactions: [TransactionInfo]?
    public var reason: Item.Reason?
    public var amount: Money?
    public var messages: [Message]?
    public var responseDue: String?
    
    public init(transactions: [TransactionInfo]?, reason: Item.Reason?, amount: Money?, messages: [Message]?, responseDue: String?) {
        self.id = nil
        self.status = nil
        self.outcome = nil
        self.lifecycleStage = nil
        self.channel = nil
        self.offer = nil
        self.links = nil
        self.created = nil
        self.updated = nil
        
        self.transactions = transactions
        self.reason = reason
        self.amount = amount
        self.messages = messages
        self.responseDue = responseDue
    }
}
