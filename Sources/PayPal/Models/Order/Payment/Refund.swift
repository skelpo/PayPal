import Vapor

/// A refund for a purchased unit.
public struct Refund {
    
    /// The ID of the refund transaction. Maximum length is 17 characters.
    public let id: String?
    
    /// The ID of the sale transaction to refund.
    public let capture: String?
    
    /// The ID of the sale transaction to refund.
    public let sale: String?
    
    /// The status of the refund.
    public let status: Status?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// The amount that is refunded to the payer and the amount that is refunded to the payee.
    ///
    /// Maximum length is 10 characters, which includes:
    /// - Seven digits before the decimal point.
    /// - The decimal point.
    /// - Two digits after the decimal point.
    public let amount: DetailedAmount?
    
    
    /// Creates a new `Refund` instance.
    ///
    /// - Parameter amount: The amount that is refunded to the payer and the amount that is refunded to the payee.
    public init(amount: DetailedAmount?) {
        self.id = nil
        self.capture = nil
        self.sale = nil
        self.status = nil
        self.links = nil
        self.amount = amount
    }
    
    enum CodingKeys: String, CodingKey {
        case id, status, links, amount
        case capture = "capture_id"
        case sale = "sale_id"
    }
}

extension Refund {
    
    /// The status of a refund instance.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The refund is pending.
        case pending = "PENDING"
        
        /// The refund completed.
        case completed = "COMPLETED"
        
        /// The refund failed.
        case failed = "FAILED"
    }
}
