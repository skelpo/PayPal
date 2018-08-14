import Vapor

/// An email container for for sending notiifications email.
public struct CCEmail: Content, ValidationSetable, Equatable {
    
    /// A CC: email to which to send a notification email.
    ///
    /// This property can be set by the `CCEmail.set(_:)` method. This method will
    /// validate the the new value before assigning it to the property.
    ///
    /// Minimum length: 3. Maximum length: 254. Pattern: `^.+@[^"\-].+$`.
    public private(set) var email: String?
    
    /// Creates a new `CCEmail` instance.
    ///
    ///     CCEmail(email: "holmer@shlock.com")
    public init(email: String?)throws {
        self.email = email
        
        try self.set(\.email <~ email)
    }
    
    /// See [`Decoder.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        self.email = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .email)
        
        try self.set(\.email <~ self.email)
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
    
    enum CodingKeys: String, CodingKey {
        case email = "cc_email"
    }
}
