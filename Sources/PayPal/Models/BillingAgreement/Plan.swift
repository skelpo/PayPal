import Vapor

public struct Plan: Content, Equatable {
    public let id: String?
    public var name: String
    public var description: String
    public var type: PlanType
    public let state: PlanState?
    public let created: Date?
    public let updated: Date?
    public var paymentDefinitions: [Payment]?
    public let terms: [Term]?
    public var preferances: MerchantPreferances?
    public let currency: Currency?
    public let links: [LinkDescription]?
    
    public init(name: String, description: String, type: PlanType, payments: [Payment]?, preferances: MerchantPreferances?) {
        self.id = nil
        self.state = nil
        self.created = nil
        self.updated = nil
        self.terms = nil
        self.currency = nil
        self.links = nil
        
        self.name = name
        self.description = description
        self.type = type
        self.paymentDefinitions = payments
        self.preferances = preferances
    }
}
