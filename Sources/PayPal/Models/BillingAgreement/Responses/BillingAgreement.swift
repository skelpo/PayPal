import Vapor

/// An agreement for a recurring PayPal or debit card payment for goods or services.
public struct BillingAgreement: Content, ValidationSetable, Equatable {
    
    /// The PayPal-generated ID for the resource.
    ///
    /// Maximum length: 128.
    public let id: String?
    
    /// The state of the agreement.
    public let state: AgreementState?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    /// The agreement name.
    ///
    /// Maximum length: 128.
    public var name: String?
    
    /// The agreement description.
    ///
    /// Maximum length: 128.
    public var description: String?
    
    /// The date and time when this agreement begins, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// The start date must be no less than 24 hours after the current date as the agreement can take up to 24 hours to activate.
    ///
    /// The start date and time in the create agreement request might not match the start date and time that the API returns in the
    /// execute agreement response. When you execute an agreement, the API internally converts the start date and time to the start
    /// of the day in the time zone of the merchant account. For example, the API converts a `2017-01-02T14:36:21Z` start date and time
    /// for an account in the Berlin time zone (UTC + 1) to `2017-01-02T00:00:00`. When the API returns this date and time in the execute
    /// agreement response, it shows the converted date and time in the UTC time zone. So, the internal `2017-01-02T00:00:00` start date
    /// and time becomes `2017-01-01T23:00:00` externally.
    public var start: String?
    
    /// The agreement details.
    public var details: Details?
    
    /// The details for the customer who funds the payment. The API gathers this information from execution of the approval URL.
    public var payer: Payer?
    
    /// The shipping address of the agreement, which must be provided if it differs from the default address.
    public var shippingAddress: Address?
    
    /// The merchant preferences that override the default information in the plan. If you omit this parameter,
    /// the agreement uses the default merchant preferences from the plan. The merchant preferences include how much it costs to set up the agreement,
    /// the URLs where the customer can approve or cancel the agreement, the maximum number of allowed failed payment attempts, whether PayPal
    /// automatically bills the outstanding balance in the next billing cycle, and the action if the customer's initial payment fails.
    public var overrideMerchantPreferances: MerchantPreferances?
    
    /// An array of charge models to override the charge models in the plan. A charge model defines shipping fee and tax information.
    /// If you omit this parameter, the agreement uses the default shipping fee and tax information from the plan.
    public var overrideChargeModels: [OverrideCharge]?
    
    /// The plan that can be used to create an agreement.
    public var plan: Plan?
    
    /// Creates a new `BillingAgreement` instance.
    ///
    ///     BillingAgreement(
    ///         name: "Nia's Maggot Loaf",
    ///         description: "Weekly maggot loaf subscription",
    ///         start: Date().iso8601,
    ///         details: nil,
    ///         payer: Payer(
    ///             method: .paypal,
    ///             fundingInstruments: nil,
    ///             info: nil
    ///         ),
    ///         shippingAddress: nil,
    ///         overrideMerchantPreferances: nil,
    ///         overrideChargeModels: nil,
    ///         plan: Plan(
    ///             name: "Nia's Maggot Loaf",
    ///             description: "Weekly maggot loaf subscription",
    ///             type: .infinate,
    ///             payments: nil,
    ///             preferances: nil
    ///         )
    ///     )
    public init(
        name: String?,
        description: String?,
        start: String?,
        details: Details?,
        payer: Payer?,
        shippingAddress: Address?,
        overrideMerchantPreferances: MerchantPreferances?,
        overrideChargeModels: [OverrideCharge]?,
        plan: Plan?
    )throws {
        self.id = nil
        self.state = nil
        self.links = nil
        
        self.name = name
        self.description = description
        self.start = start
        self.details = details
        self.payer = payer
        self.shippingAddress = shippingAddress
        self.overrideMerchantPreferances = overrideMerchantPreferances
        self.overrideChargeModels = overrideChargeModels
        self.plan = plan
        
        try self.set(\.name <~ name)
        try self.set(\.description <~ description)
    }
    
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decodeIfPresent(String.self, forKey: .id)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        let description = try container.decodeIfPresent(String.self, forKey: .description)
        
        guard id?.count ?? 0 <= 128 else {
            throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`id` property must have a length of 128 or less")
        }
        
        self.id = id
        self.name = name
        self.description = description
        self.state = try container.decodeIfPresent(AgreementState.self, forKey: .state)
        self.start = try container.decodeIfPresent(String.self, forKey: .start)
        self.details = try container.decodeIfPresent(Details.self, forKey: .details)
        self.payer = try container.decodeIfPresent(Payer.self, forKey: .payer)
        self.shippingAddress = try container.decodeIfPresent(Address.self, forKey: .shippingAddress)
        self.overrideMerchantPreferances = try container.decodeIfPresent(MerchantPreferances.self, forKey: .overrideMerchantPreferances)
        self.overrideChargeModels = try container.decodeIfPresent([OverrideCharge].self, forKey: .overrideChargeModels)
        self.plan = try container.decodeIfPresent(Plan.self, forKey: .plan)
        self.links = try container.decodeIfPresent([LinkDescription].self, forKey: .links)
        
        try self.set(\.name <~ name)
        try self.set(\.description <~ description)
    }
    
    public func setterValidations() -> SetterValidations<BillingAgreement> {
        var validations = SetterValidations(BillingAgreement.self)
        
        validations.set(\.name) { name in
            guard name?.count ?? 0 <= 128 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`name` property must have a length of 128 or less")
            }
        }
        validations.set(\.description) { description in
            guard description?.count ?? 0 <= 128 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`description` property must have a length of 128 or less")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case id, state, links, name, description, payer, plan
        case start = "start_date"
        case details = "agreement_details"
        case shippingAddress = "shipping_address"
        case overrideMerchantPreferances = "override_merchant_preferences"
        case overrideChargeModels = "override_charge_models"
    }
}