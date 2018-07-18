import Vapor

public struct Details: Content, Equatable {
    public var oustanding: Money?
    public var cyclesRemaining: String?
    public var cyclesComplete: String?
    public var nextBilling: Date?
    public var lastPaymentDate: Date?
    public var lastPaymentAmount: Money?
    public var finalPaymentDate: Date?
    public var failedPaymentCount: String?
    
    public init(
        outstanding: Money?,
        cyclesRemaining: String?,
        cyclesComplete: String?,
        nextBilling: Date?,
        lastPaymentDate: Date?,
        lastPaymentAmount: Money?,
        finalPaymentDate: Date?,
        failedPaymentCount: String?
    ) {
        self.oustanding = outstanding
        self.cyclesRemaining = cyclesRemaining
        self.cyclesComplete = cyclesComplete
        self.nextBilling = nextBilling
        self.lastPaymentDate = lastPaymentDate
        self.lastPaymentAmount = lastPaymentAmount
        self.finalPaymentDate = finalPaymentDate
        self.failedPaymentCount = failedPaymentCount
    }
}
