import Vapor

/// See `EmailType` struct.
public typealias CCEmail = EmailType<CCEmailKeys>

/// See `EmailType` struct.
public typealias Email = EmailType<EmailKeys>

/// See `EmailType` struct.
public typealias EmailAddress = EmailType<EmailAddressKeys>

// MARK: - Coding Keys

/// The coding keys required for encoding/decoding an `Email` object.
public protocol EmailCodingKey: CodingKey {
    
    /// The coding key for encoding/decoding the `email` property.
    static var email: Self { get }
}

/// Coding keys for emails using the `cc_email` JSON key.
public enum CCEmailKeys: String, EmailCodingKey {
    
    /// `cc_email`
    case _email = "cc_email"
    
    /// See `EmailCodingKey.email`.
    public static var email: CCEmailKeys { return ._email }
}

/// Coding keys for emails using the `email` JSON key.
public enum EmailKeys: String, EmailCodingKey {
    
    /// `email`
    case _email = "email"
    
    /// See `EmailCodingKey.email`.
    public static var email: EmailKeys { return ._email }
}

/// Coding keys for emails using the `email_address` JSON key.
public enum EmailAddressKeys: String, EmailCodingKey {
    
    /// `email_address`
    case _email = "email_address"
    
    /// See `EmailCodingKey.email`.
    public static var email: EmailAddressKeys { return ._email }
}
// MARK: - Generic Struct

/// An email container for for sending notiifications email.
public struct EmailType<Keys>: Content, ValidationSetable, Equatable where Keys: EmailCodingKey {
    
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
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        self.email = try decoder.container(keyedBy: Keys.self).decode(String.self, forKey: .email)
        
        try self.set(\.email <~ self.email)
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(self.email, forKey: .email)
    }
    
    /// See `ValidationSetable.setterValidations()`
    public func setterValidations() -> SetterValidations<EmailType<Keys>> {
        var validations = SetterValidations(EmailType<Keys>.self)
        
        validations.set(\.email) { email in
            guard let email = email else { return }
            guard email.count >= 3 && email.count <= 254 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`email` property must have a length between 3 and 254")
            }
            guard email.range(of: "^.+@[^\"\\-].+$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`email` property must match RegEx pattern `^.+@[^\"\\-].+$`")
            }
        }
        
        return validations
    }
}
