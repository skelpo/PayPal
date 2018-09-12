import Vapor

/// The detaild data of a PayPal merchant account.
public struct MerchantAccount: Content, ValidationSetable, Equatable {
    
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
    /// This property can be set using the `MerchantAccount.set(_:)` method. This method
    /// validatse the new value before assigning it to the property.
    ///
    /// Maximum length: 127.
    public private(set) var partnerExternalID: String?
    
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
    ///         signupOptions: SignupOptions(partner: nil, legal: nil, web: nil, notification: nil),
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
    )throws {
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
        
        try self.set(\.partnerExternalID <~ partnerExternalID)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let partnerExternalID = try container.decodeIfPresent(String.self, forKey: .partnerExternalID)
        
        self.partnerExternalID = partnerExternalID
        self.links = try container.decodeIfPresent([LinkDescription].self, forKey: .links)
        self.owner = try container.decodeIfPresent(BusinessOwner.self, forKey: .owner)
        self.business = try container.decodeIfPresent(Business.self, forKey: .business)
        self.status = try container.decodeIfPresent(AccountStatus.self, forKey: .status)
        self.currency = try container.decodeIfPresent(Currency.self, forKey: .currency)
        self.seconderyCurrencies = try container.decodeIfPresent([Currency].self, forKey: .seconderyCurrencies)
        self.paymentReceiving = try container.decodeIfPresent(PaymentReceivingPreferences.self, forKey: .paymentReceiving)
        self.relations = try container.decodeIfPresent([AccountRelation].self, forKey: .relations)
        self.permissions = try container.decodeIfPresent([AccountPermission].self, forKey: .permissions)
        self.timezone = try container.decodeIfPresent(Timezone.self, forKey: .timezone)
        self.partnerExternalID = try container.decodeIfPresent(String.self, forKey: .partnerExternalID)
        self.loginable = try container.decodeIfPresent(Bool.self, forKey: .loginable)
        self.partnerTaxReporting = try container.decodeIfPresent(Bool.self, forKey: .partnerTaxReporting)
        self.signupOptions = try container.decodeIfPresent(SignupOptions.self, forKey: .signupOptions)
        self.errors = try container.decodeIfPresent([AccountError].self, forKey: .errors)
        
        try self.set(\.partnerExternalID <~ partnerExternalID)
    }
    
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<MerchantAccount> {
        var validations = SetterValidations(MerchantAccount.self)
        
        validations.set(\.partnerExternalID) { id in
            guard let id = id else { return }
            guard id.count <= 127 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`partnerExternalID` value length must be 127 or less")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case links, timezone, loginable, errors
        case owner = "owner_info"
        case business = "business_info"
        case status = "account_status"
        case currency = "account_currency"
        case seconderyCurrencies = "secondary_currency"
        case paymentReceiving = "payment_receiving_preferences"
        case relations = "account_relations"
        case permissions = "account_permissions"
        case partnerExternalID = "partner_merchant_external_id"
        case partnerTaxReporting = "partner_tax_reporting"
        case signupOptions = "signup_options"
    }
}
