import PayPal

/// A fee, commission, tip, or donation.
public struct PlatformFee: Codable {
    
    /// The fee for a transaction.
    public let amount: CurrencyCodeAmount
    
    /// The recipient of the fee for this transaction. If you omit this value, the default is the API caller.
    public let payee: PayeeBase?
    
    /// Creates a new `PlatformFee` instance.
    ///
    /// - Parameters:
    ///   - amount: The fee for a transaction.
    ///   - payee: The recipient of the fee for this transaction.
    public init(amount: CurrencyCodeAmount, payee: PayeeBase? = nil) {
        self.amount = amount
        self.payee = payee
    }
}
