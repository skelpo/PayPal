import Vapor

public struct NewAgreement: Content, Equatable {
    public var name: String
    public var description: String
    public var start: String
    public var details: Details?
    public var payer: Payer
    public var shippingAddress: Address?
    public var overrideMerchantPreferances: MerchantPreferances?
    public var overrideChargeModels: [OverrideCharge]?
    public var plan: Plan
    
    public init(
        name: String,
        description: String,
        start: String,
        payer: Payer,
        plan: Plan,
        details: Details? = nil,
        shippingAddress: Address? = nil,
        overrideMerchantPreferances: MerchantPreferances,
        overrideChargeModels: [OverrideCharge]?
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
}
