import Vapor

/// A customer's dispute about an invalid transaction.
public struct CustomerDispute: Content, Equatable {
    
    /// The ID of the dispute.
    public let id: String?
    
    /// The date and time when the dispute was created, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let created: ISO8601Date?
    
    /// The date and time when the dispute was updated, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let updated: ISO8601Date?
    
    /// The status of the dispute.
    public let status: Status?
    
    /// The outcome of a dispute.
    public let outcome: Outcome?
    
    /// The stage in the dispute lifecycle.
    public let lifecycleStage: LifeCycleStage?
    
    /// The channel where the dispute was created.
    public let channel: Channel?
    
    /// The merchant-proposed offer for a dispute.
    public let offer: Offer?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// An array of transactions for which the disputes were created.
    public var transactions: [TransactionInfo]?
    
    /// The reason for the item-level dispute.
    public var reason: Item.Reason?
    
    /// The amount in the transaction that the customer originally disputed. Because customers can sometimes dispute
    /// only part of the payment, the disputed amount might be different from the total gross or net amount of the original transaction.
    public var amount: CurrencyCodeAmount?
    
    /// An array of messages that the customer or merchant posted.
    public var messages: [Message]?
    
    /// The date and time by when the merchant must respond to the dispute, in
    /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public var responseDue: ISO8601Date?
    
    
    /// Creates a new `CustomerDispute` instance.
    ///
    /// - Parameters:
    ///   - transactions: An array of transactions for which the disputes were created.
    ///   - reason: The reason for the item-level dispute.
    ///   - amount: The amount in the transaction that the customer originally disputed.
    ///   - messages: An array of messages that the customer or merchant posted.
    ///   - responseDue: The date and time by when the merchant must respond to the dispute, in Internet date and time format.
    public init(transactions: [TransactionInfo]?, reason: Item.Reason?, amount: CurrencyCodeAmount?, messages: [Message]?, responseDue: Date?) {
        self.id = nil
        self.created = nil
        self.updated = nil
        self.status = nil
        self.outcome = nil
        self.lifecycleStage = nil
        self.channel = nil
        self.offer = nil
        self.links = nil
        
        self.transactions = transactions
        self.reason = reason
        self.amount = amount
        self.messages = messages
        self.responseDue = responseDue == nil ? nil : ISO8601Date(responseDue!)
    }
    
    enum CodingKeys: String, CodingKey {
        case reason, status, messages, offer, links
        case id = "dispute_id"
        case created = "create_time"
        case updated = "update_time"
        case transactions = "disputed_transactions"
        case amount = "dispute_amount"
        case outcome = "dispute_outcome"
        case lifecycleStage = "dispute_life_cycle_stage"
        case channel = "dispute_channel"
        case responseDue = "seller_response_due_date"
    }
}
