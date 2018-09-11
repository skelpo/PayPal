import Vapor

/// Custom preferances for a customers web experience.
public struct WebExperiencePreference: Content, Equatable {
    
    /// The partner logo URL to show in the seller onboarding flow.
    public var partnerLogo: String?
    
    /// The URL to which to redirect the customer upon completion of the onboarding process.
    public var returnURL: String?
    
    /// The description of the return URL.
    public var returnDescription: String?
    
    /// If `renew_action_url` expires, redirect the customer to this URL.
    public var actionRenewal: String?
    
    /// Indicates whether to show an add credit card page.
    public var showAddCC: Bool?
    
    /// Indicates whether to ask the customer to initiate confirmation of their mobile phone.
    /// This phone is the one that the partner defined as `MOBILE` in the customer data. Default is `false`.
    public var mobileConfirmation: Bool?
    
    /// Indicates whether to provide a single page signup flow in a mini browser. Default is `false`, which provides a full-size, multi-page flow.
    public var miniBrowser: Bool?
    
    /// Indicates whether to use the `hosted_user_agreement_url` to confirm the customer's email address. If `TRUE`,
    /// PayPal appends the email confirmation code to `hosted_user_agreement_url`. When a customer successfully accesses the hosted user agreement URL,
    /// PayPal confirms the customer's email address. If `false`, PayPal does not append the confirmation code to the URL and does not confirm the email address.
    public var emailConfirmation: Bool?
    
    
    /// Creates a new `WebExperiencePreference` instance.
    ///
    ///     WebExperiencePreference(
    ///         partnerLogo: "https://example.com/image.png",
    ///         returnURL: "https://example.com/complete",
    ///         returnDescription: "Back to where you came from.",
    ///         actionRenewal: "https://example.com/renew",
    ///         showAddCC: true,
    ///         emailConfirmation: true
    ///     )
    public init(
        partnerLogo: String?,
        returnURL: String?,
        returnDescription: String?,
        actionRenewal: String?,
        showAddCC: Bool?,
        mobileConfirmation: Bool? = false,
        miniBrowser: Bool? = false,
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
