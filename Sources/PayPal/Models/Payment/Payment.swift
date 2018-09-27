import Vapor

public struct Payment: Content, Equatable {
    public let id: String?
    public let state: State?
    public let failure: Failure?
    public let created: String?
    public let updated: String?
    public let links: [LinkDescription]?
    
    public var intent: Intent?
    public var payer: PaymentPayer?
    public var context: AppContext?
    public var transactions: [Transaction]?
    public var experience: String?
    public var payerNote: String?
    public var redirects: Redirects?
    
    public init(
       intent: Intent?,
       payer: PaymentPayer?,
       context: AppContext?,
       transactions: [Transaction]?,
       experience: String?,
       payerNote: String?,
       redirects: Redirects?
    ) {
        self.id = nil
        self.state = nil
        self.failure = nil
        self.created = nil
        self.updated = nil
        self.links = nil
        
        self.intent = intent
        self.payer = payer
        self.context = context
        self.transactions = transactions
        self.experience = experience
        self.payerNote = payerNote
        self.redirects = redirects
    }
}
