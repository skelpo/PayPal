import Vapor

let dateRegex = "^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$"

/// A customer's dispute about an invalid transaction.
public struct CustomerDispute: Content, ValidationSetable, Equatable {
    
    /// The ID of the dispute.
    public let id: String?
    
    /// The date and time when the dispute was created, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// For example, `yyyy`-`MM`-`ddTHH`:`mm`:`ss`.`SSSZ`.
    ///
    /// Minimum length: 20. Maximum length: 64. The value must match this RegEx pattern:
    ///
    ///     ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$
    public let created: String?
    
    /// The date and time when the dispute was updated, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// For example, `yyyy`-`MM`-`ddTHH`:`mm`:`ss`.`SSSZ`.
    ///
    /// Minimum length: 20. Maximum length: 64. The value must match this RegEx pattern:
    ///
    ///     ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$
    public let updated: String?
    
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
    
    /// The date and time by when the merchant must respond to the dispute, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// For example, `yyyy`-`MM`-`ddTHH`:`mm`:`ss`.`SSSZ`.
    ///
    /// Minimum length: 20. Maximum length: 64. The value must match this RegEx pattern:
    ///
    ///     ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$
    public var responseDue: String?
    
    
    /// Creates a new `CustomerDispute` instance.
    ///
    ///     CustomerDispute(
    ///         transactions: [
    ///             TransactionInfo(
    ///                 buyerID: "DECDF8E7-59EE-4D3A-9347-5FC39B6CA75A",
    ///                 sellerID: "3DE7148F-360E-4F22-9DE2-8507E24DB60B",
    ///                 created: Date().iso8601,
    ///                 status: .pending,
    ///                 gross: Money(currency: .usd, value: "89.45"),
    ///                 invoice: "C80ED435-DBB2-456B-A1EF-2750A32AAF1A",
    ///                 custom: nil,
    ///                 buyer: Buyer(email: "witheringheights@exmaple.com", name: "Leeli Wingfeather"),
    ///                 seller: Seller(email: "throg@exmaple.com", name: "Nag the Nameless", merchantID: nil)
    ///             )
    ///         ],
    ///         reason: .unauthorized,
    ///         amount: Money(currency: .usd, value: "89.45"),
    ///         messages: nil,
    ///         responseDue: Date(timeIntervalSinceNow: 60 * 60 * 24).iso8601
    ///     )
    public init(transactions: [TransactionInfo]?, reason: Item.Reason?, amount: CurrencyCodeAmount?, messages: [Message]?, responseDue: String?)throws {
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
        self.responseDue = responseDue
        
        try self.set(\.responseDue <~ responseDue)
    }
    
    /// See [`Decoder.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseDue = try container.decodeIfPresent(String.self, forKey: .responseDue)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.created = try container.decodeIfPresent(String.self, forKey: .created)
        self.updated = try container.decodeIfPresent(String.self, forKey: .updated)
        self.status = try container.decodeIfPresent(Status.self, forKey: .status)
        self.outcome = try container.decodeIfPresent(Outcome.self, forKey: .outcome)
        self.lifecycleStage = try container.decodeIfPresent(LifeCycleStage.self, forKey: .lifecycleStage)
        self.channel = try container.decodeIfPresent(Channel.self, forKey: .channel)
        self.offer = try container.decodeIfPresent(Offer.self, forKey: .offer)
        self.links = try container.decodeIfPresent([LinkDescription].self, forKey: .links)
        
        self.transactions = try container.decodeIfPresent([TransactionInfo].self, forKey: .transactions)
        self.reason = try container.decodeIfPresent(Item.Reason.self, forKey: .reason)
        self.amount = try container.decodeIfPresent(CurrencyCodeAmount.self, forKey: .amount)
        self.messages = try container.decodeIfPresent([Message].self, forKey: .messages)
        self.responseDue = try container.decodeIfPresent(String.self, forKey: .responseDue)
        
        try self.set(\.responseDue <~ responseDue)
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<CustomerDispute> {
        var validations = SetterValidations(CustomerDispute.self)
        
        validations.set(\.responseDue) { due in
            guard let due = due else { return }
            guard let _ = due.range(of: dateRegex, options: .regularExpression) else {
                throw PayPalError(
                    status: .badRequest,
                    identifier: "malformedString",
                    reason: "`seller_response_due_date` property value must match '\(dateRegex)' RegEx pattern"
                )
            }
            guard due.count >= 20 && due.count <= 64 else {
                throw PayPalError(
                    status: .badRequest,
                    identifier: "invalidLength",
                    reason: "`seller_response_due_date` property must have a length between 20 and 64"
                )
            }
        }
        
        return validations
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
