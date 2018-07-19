import Vapor

public struct BillingAgreement: Content, Equatable {
    public let id: String?
    public let state: AgreementState?
    public let links: [LinkDescription]?
    public var name: String?
    public var description: String?
    public var start: String?
    public var details: Details?
    public var payer: Payer?
    public var shippingAddress: Address?
    public var overrideMerchantPreferances: MerchantPreferances?
    public var overrideChargeModels: [OverrideCharge]?
    public var plan: Plan?
    
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
    ) {
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
    }
}
