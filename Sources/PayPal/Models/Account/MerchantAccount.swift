import Vapor

public struct MerchantAccount: Content, Equatable {
    public let links: [LinkDescription]?
    
    public var owner: BusinessOwner?
    public var business: Business?
    public var status: AccountStatus?
    public var currency: Currency?
    public var seconderyCurrencies: [Currency]?
    public var paymentReceiving: PaymentReceivingPreferences?
    public var relations: [AccountRelation]?
    public var permissions: [AccountPermission]?
    public var timezone: Timezone?
    public var partnerExternalID: String?
    public var loginable: Bool?
    public var partnerTaxReporting: Bool?
    public var signupOptions: SignupOptions?
    public var errors: [AccountError]?
    
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
