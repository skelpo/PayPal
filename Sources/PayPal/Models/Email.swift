import Vapor

/// See `EmailType` struct.
public typealias CCEmail = EmailType<CCEmailKeys>

/// See `EmailType` struct.
public typealias Email = EmailType<EmailKeys>

/// See `EmailType` struct.
///
/// - Note: Up to 64 characters are allowed before and 255 characters are allowed after the @ sign.
///   However, the generally accepted maximum length for an email address is 254 characters. The pattern verifies that an unquoted @ sign exists.
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
public struct EmailType<Keys>: Content, Equatable where Keys: EmailCodingKey {
    
    /// A CC: email to which to send a notification email.
    ///
    /// Minimum length: 3. Maximum length: 254. Pattern: `^.+@[^"\-].+$`.
    public var email: Failable<String, EmailString>
    
    /// Creates a new `CCEmail` instance.
    ///
    /// - Parameter email: A CC: email to which to send a notification email.
    public init(email: Failable<String, EmailString>) {
        self.email = email
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        self.email = try decoder.container(keyedBy: Keys.self).decode(Failable<String, EmailString>.self, forKey: .email)
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(self.email, forKey: .email)
    }
}
