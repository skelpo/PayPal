import Vapor

public struct SignupOptions: Content, Equatable {
    public var partner: PartnerOptions?
    public var legal: [LegalAgreement]?
    public var web: WebExperiencePreference?
    public var notification: NotificationOptions?
    
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
