import Vapor

/// The buyer party of a customer dispute.
public struct Buyer: Content, ValidationSetable, Equatable {
    
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
    
    public func setterValidations() -> SetterValidations<Buyer> {
        var validations = SetterValidations(Buyer.self)
        
        validations.set(\.email) { email in
            guard let email = email else { return }
            guard let _ = email.range(of: "^.+@[^\"\\-].+$", options: .regularExpression) else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`email` property value must match '^.+@[^\"\\-].+$' RegEx pattern")
            }
            guard email.count >= 3 && email.count <= 254 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`email` property must have a length between 3 and 254")
            }
        }
        
        return validations
    }
}
