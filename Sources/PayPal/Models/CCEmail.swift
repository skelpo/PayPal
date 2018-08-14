import Vapor

/// An email container for for sending notiifications email.
public struct CCEmail: Content, ValidationSetable, Equatable {
    
    /// A CC: email to which to send a notification email.
    ///
    /// Minimum length: 3. Maximum length: 254. Pattern: `^.+@[^"\-].+$`.
    public var email: String?
    
    /// Creates a new `CCEmail` instance.
    ///
    ///     CCEmail(email: "holmer@shlock.com")
    public init(email: String?) {
        self.email = email
    }
    
    /// See `ValidationSetable.setterValidations()`
    public func setterValidations() -> SetterValidations<CCEmail> {
        var validations = SetterValidations(CCEmail.self)
        
        validations.set(\.email) { email in
            guard let email = email else { return }
            guard email.count <= 3 && email.count >= 254 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`email` property must have a length between 3 and 254")
            }
            guard email.range(of: "^.+@[^\"\\-].+$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`email` property must match RegEx pattern `^.+@[^\"\\-].+$`")
            }
        }
        
        return validations
    }
}
