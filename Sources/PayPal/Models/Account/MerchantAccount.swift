import Vapor

/// The detaild data of a PayPal merchant account.
public struct MerchantAccount: Content, Equatable {
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// The account holder's information.
    public var owner: BusinessOwner?
    
    /// The business information for the merchant.
    public var business: Business?
    
    /// The account status.
    public var status: AccountStatus?
    
    /// The currency code for the account.
    public var currency: Currency?
    
    /// An array of secondary currencies. In addition to the account currency, the merchant account can accept transactions in other currencies.
    public var seconderyCurrencies: [Currency]?
    
    /// The account preferences for receipt of payments.
    public var paymentReceiving: PaymentReceivingPreferences?
    
    /// An array of account relationships between the parent and this account.
    public var relations: [AccountRelation]?
    
    /// An array of permissions to assign to the account.
    public var permissions: [AccountPermission]?
    
    /// The time zone.
    public var timezone: Timezone?
    
    /// An ID that the partner creates for the merchant account. Note: This information is not available for retrieval.
    ///
    /// Maximum length: 127.
    public var partnerExternalID: String?
    
    /// Whether the account allows the merchant to log in. Accounts managed by their parent only are not loginable.
    public var loginable: Bool?
    
    /// Whether the partner reports taxes for the account. Note: This information is not available for retrieval.
    public var partnerTaxReporting: Bool?
    
    /// The partner options to assign to the merchant account.
    public var signupOptions: SignupOptions?
    
    /// An array of errors that can occur when you add bundles to a customer account.
    public var errors: [AccountError]?
    
    
    /// Creates a new `MerchantAccount` instance.
    ///
    ///     MerchantAccount(
    ///         owner: nil,
    ///         business: nil,
    ///         status: .a,
    ///         currency: .usd,
    ///         seconderyCurrencies: [],
    ///         paymentReceiving: PaymentReceivingPreferences(),
    ///         relations: [],
    ///         permissions: [],
    ///         timezone: .chicago,
    ///         partnerExternalID: "F42E7896-17E3-455C-9B85-5F96729A4FD9",
    ///         loginable: true,
    ///         partnerTaxReporting: false,
    ///         signupOptions: SignupOptions(partner: nil, legal: nil, web: , notification: nil),
    ///         errors: []
    ///     )
    public init(
        owner: BusinessOwner?,
        business: Business?,
        status: AccountStatus?,
        currency: Currency?,
        seconderyCurrencies: [Currency]?,
        paymentReceiving: PaymentReceivingPreferences?,
        relations: [AccountRelation]?,
        permissions: [AccountPermission]?,
        timezone: Timezone?,
        partnerExternalID: String?,
        loginable: Bool?,
        partnerTaxReporting: Bool?,
        signupOptions: SignupOptions?,
        errors: [AccountError]?
    ) {
        self.links = nil
        
        self.owner = owner
        self.business = business
        self.status = status
        self.currency = currency
        self.seconderyCurrencies = seconderyCurrencies
        self.paymentReceiving = paymentReceiving
        self.relations = relations
        self.permissions = permissions
        self.timezone = timezone
        self.partnerExternalID = partnerExternalID
        self.loginable = loginable
        self.partnerTaxReporting = partnerTaxReporting
        self.signupOptions = signupOptions
        self.errors = errors
    }
}
