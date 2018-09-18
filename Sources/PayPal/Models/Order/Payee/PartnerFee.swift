import Vapor

/// A partner fee that is collected for an order transaction.
public struct PartnerFee: Content, Equatable {
    
    /// The partner who receives the partner fee.
    public var receiver: Payee
    
    /// The amount and currency of the partner fee.
    public var amount: Amount
    
    /// Creates a new `PartnerFee` instance.
    ///
    /// - Parameters:
    ///   - receiver: The partner who receives the partner fee.
    ///   - amount: The amount and currency of the partner fee.
    public init(receiver: Payee, amount: Amount) {
        self.receiver = receiver
        self.amount = amount
    }
}
