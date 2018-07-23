import Vapor

/// A billing agreement transaction.
public struct Transaction: Content, Equatable {
    
    /// The ID of the transaction.
    public let id: String?
    
    /// The current status of the transaction.
    public let state: State?
    
    /// The type of transaction. Typically, `Recurring Payment`.
    public let type: String?
    
    /// The email ID of the customer.
    public let email: String?
    
    /// The business name of the customer.
    public let name: String?
    
    /// The date and time when the transaction occurred,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let timestamp: String?
    
    /// The time zone of the `update_time` field.
    public let timezone: String?
    
    /// The currency and amount of the transaction.
    public var amount: Money
    
    /// The currency and amount of the transaction fee.
    public var fee: Money
    
    /// The currency and amount of the transaction net amount.
    public var net: Money
    
    /// Creates a new `Transaction` instance. Assigns values to the `amount`, `fee`, and `net` properties,
    /// all other properties are `nil`.
    ///
    /// You probably won't ever need this initializer. For the most part,
    /// `.init(from:)` decoder init should be all you need.
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
