import Vapor

/// The body of the POST request used to create a new billing agreement on PayPal.
///
/// https://developer.paypal.com/docs/api/payments.billing-agreements/v1/#billing-agreements-create-request-body
public struct NewAgreement: Content, Equatable {
    
    /// The agreement name.
    ///
    /// Maximum length: 128.
    public var name: Failable<String, Length128<String>>
    
    /// The agreement description.
    ///
    /// Maximum length: 128.
    public var description: Failable<String, Length128<String>>
    
    /// The date and time when this agreement begins, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// The start date must be no less than 24 hours after the current date as the agreement can take up to 24 hours to activate.
    ///
    /// The start date and time in the create agreement request might not match the start date and time that the API returns in the
    /// execute agreement response. When you execute an agreement, the API internally converts the start date and time to the start
    /// of the day in the time zone of the merchant account. For example, the API converts a `2017-01-02T14:36:21Z` start date and time
    /// for an account in the Berlin time zone (UTC + 1) to `2017-01-02T00:00:00`. When the API returns this date and time in the execute
    /// agreement response, it shows the converted date and time in the UTC time zone. So, the internal `2017-01-02T00:00:00` start date
    /// and time becomes `2017-01-01T23:00:00` externally.
    public var start: String
    
    /// The agreement details.
    public var details: Details?
    
    /// The details for the customer who funds the payment. The API gathers this information from execution of the approval URL.
    public var payer: Payer
    
    /// The shipping address for a payment. Must be provided if it differs from the default address.
    public var shippingAddress: Address?
    
    /// The merchant preferences that override the default information in the plan. If you omit this parameter,
    /// the agreement uses the default merchant preferences from the plan. The merchant preferences include how much it costs to set up the agreement,
    /// the URLs where the customer can approve or cancel the agreement, the maximum number of allowed failed payment attempts, whether PayPal
    /// automatically bills the outstanding balance in the next billing cycle, and the action if the customer's initial payment fails.
    public var overrideMerchantPreferances: MerchantPreferances<CurrencyCodeAmount>?
    
    /// An array of charge models to override the charge models in the plan. A charge model defines shipping fee and tax information.
    /// If you omit this parameter, the agreement uses the default shipping fee and tax information from the plan.
    public var overrideChargeModels: [OverrideCharge]?
    
    /// The ID of the plan on which this agreement is based.
    public var plan: ID
    
    /// Creatse a new `NewAgreement` instance.
    ///
    ///     NewAgreement(
    ///         name: "Nia's Maggot Loaf",
    ///         description: "Weekly maggot loaf subscription",
    ///         start: Date().iso8601,
    ///         payer: Payer(
    ///             method: .paypal,
    ///             fundingInstruments: nil,
    ///             info: nil
    ///         ),
    ///         plan: "P-15B72BF371C34D24"
    ///     )
    public init(
        name: Failable<String, Length128<String>>,
        description: Failable<String, Length128<String>>,
        start: String,
        payer: Payer,
        plan: ID,
        details: Details? = nil,
        shippingAddress: Address? = nil,
        overrideMerchantPreferances: MerchantPreferances<CurrencyCodeAmount>? = nil,
        overrideChargeModels: [OverrideCharge]? = nil
    ) {
        self.name = name
        self.description = description
        self.start = start
        self.details = details
        self.payer = payer
        self.shippingAddress = shippingAddress
        self.overrideMerchantPreferances = overrideMerchantPreferances
        self.overrideChargeModels = overrideChargeModels
        self.plan = plan
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description, payer, plan
        case start = "start_date"
        case details = "agreement_details"
        case shippingAddress = "shipping_address"
        case overrideMerchantPreferances = "override_merchant_preferences"
        case overrideChargeModels = "override_charge_models"
    }
}
