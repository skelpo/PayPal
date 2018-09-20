import Vapor

/// A funding instrument for a payment.
public struct FundingInstrument: Content, Equatable {
    
    /// The tokenized credit card details. You can use this instrument to fund a payment.
    public var token: CreditCard.Token?
    
    /// Creates a new `FundingInstrument` instance.
    ///
    /// - Parameter token: The tokenized credit card details.
    public init(token: CreditCard.Token?) {
        self.token = token
    }
}
