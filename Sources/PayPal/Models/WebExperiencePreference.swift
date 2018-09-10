import Vapor

public struct WebExperiencePreference: Content, Equatable {
    public var partnerLogo: String?
    public var returnURL: String?
    public var returnDescription: String?
    public var actionRenewal: String?
    public var showAddCC: Bool?
    public var mobileConfirmation: Bool?
    public var miniBrowser: Bool?
    public var emailConfirmation: Bool?
    
    public init(
        partnerLogo: String?,
        returnURL: String?,
        returnDescription: String?,
        actionRenewal: String?,
        showAddCC: Bool?,
        mobileConfirmation: Bool?,
        miniBrowser: Bool?,
        emailConfirmation: Bool?
    ) {
        self.partnerLogo = partnerLogo
        self.returnURL = returnURL
        self.returnDescription = returnDescription
        self.actionRenewal = actionRenewal
        self.showAddCC = showAddCC
        self.mobileConfirmation = mobileConfirmation
        self.miniBrowser = miniBrowser
        self.emailConfirmation = emailConfirmation
    }
}
