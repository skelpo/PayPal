import Vapor

/// The notification options of a user.
public struct NotificationOptions: Content, Equatable {
    
    /// Indicates whether to suppress the welcome email. By default, a welcome email is sent. To suppress the welcome email, set to `TRUE`.
    public var suppressWelcome: Bool?
    
    /// The URL to post an IPN notification.
    public var ipnNotify: String?
    
    /// The frequency with which the reminder email is sent to the PayPal user after he or she creates an account.
    public var emailFrequency: EmailFrequency?
    
    
    /// Creates a new `NotificationOptions` instance.
    ///
    /// - Parameters:
    ///   - suppressWelcome: Indicates whether to suppress the welcome email.
    ///   - ipnNotify: The URL to post an IPN notification.
    ///   - emailFrequency: The frequency with which the reminder email is sent to the PayPal user after he or she creates an account.
    public init(suppressWelcome: Bool? = nil, ipnNotify: String? = nil, emailFrequency: EmailFrequency? = nil) {
        self.suppressWelcome = suppressWelcome
        self.ipnNotify = ipnNotify
        self.emailFrequency = emailFrequency
    }
}

extension NotificationOptions {
    
    /// The frequency with which the reminder email is sent to the PayPal user after he or she creates an account.
    public enum EmailFrequency: String, Hashable, CaseIterable, Content {
        
        /// All reminder emails are sent.
        case `default` = "DEFAULT"
        
        /// No reminder emails are sent.
        case none = "NONE"
    }
}
