import Vapor

/// Defines whether a transaction moves money into or out of an account.
public enum CreditDebitCode: String, Hashable, CaseIterable, Content {
    
    /// Includes transactions that move money into a PayPal account.
    case credit = "CREDIT"
    
    /// Includes transactions that move money out of a PayPal account.
    case debit = "DEBIT"
    
    /// Includes all transactions.
    case all = "ALL"
}
