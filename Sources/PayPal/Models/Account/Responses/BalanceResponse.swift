import Vapor

/// The current balance of an account.
public struct BalanceResponse: Content, Equatable {
    
    /// An immutable account identifier which identifies the PayPal account.
    ///
    /// Length: 13. Pattern: `^[2-9A-HJ-NP-Z]{13}$`.
    public let payer: String?
    
    /// This field contains the total available balances based on currency.
    public var available: Money?
    
    /// This field contains the total pending reversal balances based on currency.
    public var pending: Money?
}
