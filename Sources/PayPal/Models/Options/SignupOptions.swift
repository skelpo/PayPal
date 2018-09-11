import Vapor

/// Options, preferences, and agreements for an account.
public struct SignupOptions: Content, Equatable {
    
    /// The partner-specific options for the account.
    public var partner: PartnerOptions?
    
    /// An array of legal agreements.
    public var legal: [LegalAgreement]?
    
    /// The web experience preferences for the customer.
    public var web: WebExperiencePreference?
    
    /// The notification options.
    public var notification: NotificationOptions?
    
    
    /// Creates a new `SignupOptions` instance.
    ///
    /// - Parameters:
    ///   - partner: The partner-specific options for the account.
    ///   - legal: An array of legal agreements.
    ///   - web: The web experience preferences for the customer.
    ///   - notification: The notification options.
    public init(
        partner: PartnerOptions?,
        legal: [LegalAgreement]?,
        web: WebExperiencePreference?,
        notification: NotificationOptions?
    ) {
        self.partner = partner
        self.legal = legal
        self.web = web
        self.notification = notification
    }
}
