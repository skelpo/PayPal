import Vapor

/// An email container for for sending notiifications email.
public struct CCEmail: Content, Equatable {
    
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
}
