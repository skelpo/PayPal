import Vapor

/// The buyer party of a customer dispute.
public struct Buyer: Content, Equatable {
    
    /// The email address for the customer's PayPal account.
    ///
    /// Minimum length: 3. Maximum length: 254.
    /// The values for this property must match the following RegEx pattern: `^.+@[^"\-].+$`.
    public var email: Failable<String?, NotNilValidate<EmailString>>
    
    /// The customer's name.
    public var name: String?
    
    
    /// Creates a new `Buyer` instance.
    ///
    /// - Parameters:
    ///   - email: The email address for the customer's PayPal account.
    ///   - name: The customer's name.
    public init(email: Failable<String?, NotNilValidate<EmailString>>, name: String?) {
        self.email = email
        self.name = name
    }
}
