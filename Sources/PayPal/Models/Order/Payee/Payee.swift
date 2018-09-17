import Vapor

/// The recipient of funds for a transaction.
public struct Payee: Content, Equatable {
    
    /// The email address associated with the payee's PayPal account.
    ///
    /// For an intent of authorize or order, the email address must be associated with a confirmed PayPal business account.
    /// For an intent of sale, the email can either:
    /// - Be associated with a confirmed PayPal personal or business account.
    /// - Not be associated with a PayPal account.
    public var email: String?
    
    /// The PayPal account ID for the payee.
    public var merchant: String?
    
    /// The display-only metadata for the payee.
    public var metadata: Metadata?
    
    
    /// Creates a new `Payee` instance.
    ///
    /// - Parameters:
    ///   - email: The email address associated with the payee's PayPal account.
    ///   - merchant: The PayPal account ID for the payee.
    ///   - metadata: The display-only metadata for the payee.
    public init(email: String?, merchant: String?, metadata: Metadata?) {
        self.email = email
        self.merchant = merchant
        self.metadata = metadata
    }
}
