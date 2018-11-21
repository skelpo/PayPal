import Vapor

/// The item information for an item level dispute.
public struct Item: Content, Equatable {
    
    /// The item ID. If the merchant provides multiple pieces of evidence and the transaction has multiple item IDs,
    /// the merchant can use this value to associate a piece of evidence with an item ID.
    public var id: String?
    
    /// The ID of the transaction in the partner system. The partner transaction ID is returned at an item level because
    /// the partner might show different transactions for different items in the cart.
    public var transactionID: String?
    
    /// The reason for the item-level dispute.
    public var reason: Reason?
    
    /// The amount of the item in the dispute.
    public var amount: CurrencyCodeAmount?
    
    /// Any notes provided with the item.
    public var notes: String?
    
    /// Creates a new `Item` instance.
    ///
    ///     Item(
    ///         id: "3B246A14-8C7E-4866-AF5E-416A9654C269",
    ///         transactionID: "EA4C08F9-A0DC-422A-BFA4-89AE0792A84A",
    ///         reason: .incorrectAmount,
    ///         amount: Money(currency: .usd, value: "48.95"),
    ///         notes: nil
    ///     )
    public init(id: String?, transactionID: String?, reason: Reason?, amount: CurrencyCodeAmount?, notes: String?) {
        self.id = id
        self.transactionID = transactionID
        self.reason = reason
        self.amount = amount
        self.notes = notes
    }
}
