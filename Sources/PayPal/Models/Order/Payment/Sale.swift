import Vapor

/// A sale or authorization for a purchase unit in an order.
public struct Sale {
    
    /// The ID of the sale transaction.
    public let id: String?

    /// The status of the sale transaction. 
    public let status: Status?

    /// The date and time when the resource was created, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let created: String?
    
    /// The date and time when the resource was last updated, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let updated: String?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// The amount to collect. Maximum length is 10 characters, which includes:
    /// - Seven digits before the decimal point.
    /// - The decimal point.
    /// - Two digits after the decimal point.
    public var amount: DetailedAmount?
    
    /// The currency and amount of the transaction fee. Maximum length is 10 characters, which includes:
    /// - Seven digits before the decimal point.
    /// - The decimal point.
    /// - Two digits after the decimal point.
    public var transaction: Amount?
    
    
    /// Creates a new `Sale` instance.
    ///
    /// - Parameters:
    ///   - amount: The amount to collect.
    ///   - transaction: The currency and amount of the transaction fee.
    public init(amount: DetailedAmount?, transaction: Amount?) {
        self.id = nil
        self.status = nil
        self.created = nil
        self.updated = nil
        self.links = nil
        
        self.amount = amount
        self.transaction = transaction
    }
    
    enum CodingKeys: String, CodingKey {
        case id, links, amount, status
        case created = "create_time"
        case updated = "update_time"
        case transaction = "transaction_fee"
    }
}

extension Sale {
    
    /// The status of a sale transaction.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The sale completed.
        case completed = "COMPLETED"
        
        /// The sale was partially refunded.
        case partiallyRefunded = "PARTIALLY_REFUNDED"
        
        /// The sale is pending.
        case pending = "PENDING"
        
        /// The sale was refunded.
        case refunded = "REFUNDED"
        
        /// The sale was denied.
        case denied = "DENIED"
    }
}
