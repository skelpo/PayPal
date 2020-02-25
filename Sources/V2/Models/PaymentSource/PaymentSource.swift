/// The source of payment for a transaction, which can be a token or a card.
public struct PaymentSource: Codable {
    
    /// The payment card to use to fund a payment. Can be a credit or debit card.
    public var card: Card?
    
    /// The tokenized payment source to fund a payment.
    public var token: Token?
    
    /// Creates a new `PaymentSource` instance.
    ///
    /// - Parameters:
    ///   - card: The payment card to use to fund a payment.
    ///   - token: The tokenized payment source to fund a payment.
    public init(card: Card?, token: Token?) {
        self.card = card
        self.token = token
    }
}
