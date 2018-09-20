import Vapor

public struct Order: Content, Equatable {
    public let id: String?
    public let status: Status?
    public let created: String?
    public let updated: String?
    public let links: [LinkDescription]?
    
    public var intent: Intent?
    public var units: [Unit]?
    public var payment: Payment?
    public var total: Amount?
    public var context: AppContext?
    public var metadata: Metadata?
    public var redirects: Redirects?
    
    public init(
        intent: Intent?,
        units: [Unit]?,
        payment: Payment?,
        total: Amount?,
        context: AppContext?,
        metadata: Metadata?,
        redirects: Redirects?
    ) {
        self.id = nil
        self.status = nil
        self.created = nil
        self.updated = nil
        self.links = nil
        
        self.intent = intent
        self.units = units
        self.payment = payment
        self.total = total
        self.context = context
        self.metadata = metadata
        self.redirects = redirects
    }
}
