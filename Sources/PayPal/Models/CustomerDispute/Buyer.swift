import Vapor

/// The buyer party of a customer dispute.
public struct Buyer: Content, Equatable {
    
    /// The email address for the customer's PayPal account.
    ///
    /// Minimum length: 3. Maximum length: 254.
    ///
    /// The RegEx validation pattern is as following: `^.+@[^"\-].+$`.
    public var email: String?
    
    /// The customer's name.
    public var name: String?
    
    
    /// Creates a new `Buyer` instance.
    ///
    ///     Buyer(email: "witheringheights@exmaple.com", name: "Leeli Wingfeather")
    public init(email: String?, name: String?) {
        self.email = email
        self.name = name
    }
}
