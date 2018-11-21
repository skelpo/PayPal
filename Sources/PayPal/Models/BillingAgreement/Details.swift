import Vapor


/// Details for a billing agreement object.
public struct Details: Content, Equatable {
    
    /// The currency and amount of the outstanding balance for this agreement.
    public var outstanding: CurrencyCodeAmount?
    
    /// The number of payment cycles remaining for this agreement.
    public var cyclesRemaining: String?
    
    /// The number of payment cycles completed for this agreement.
    public var cyclesComplete: String?
    
    /// The next billing date and time for this agreement.
    public var nextBilling: String?
    
    /// The last payment date and time for this agreement.
    public var lastPaymentDate: String?
    
    /// The currency and amount of the last payment amount for this agreement.
    public var lastPaymentAmount: CurrencyCodeAmount?
    
    /// The final payment date and time for this agreement.
    public var finalPaymentDate: String?
    
    /// The total number of failed payments for this agreement.
    public var failedPaymentCount: String?
    
    
    /// Creates a new `Details` struct.
    ///
    ///     Details(
    ///         outstanding: Money(currency: .usd, value: "599.00"),
    ///         cyclesRemaining: "30",
    ///         cyclesComplete: "45",
    ///         nextBilling: (Date() + (60 * 60 * 24 * 365)).iso8601,
    ///         lastPaymentDate: Date().iso8601,
    ///         lastPaymentAmount: Money(currency: .usd, value: "19.97"),
    ///         finalPaymentDate: Date.distantFuture.iso8601,
    ///         failedPaymentCount: "5"
    ///     )
    public init(
        outstanding: CurrencyCodeAmount?,
        cyclesRemaining: String?,
        cyclesComplete: String?,
        nextBilling: String?,
        lastPaymentDate: String?,
        lastPaymentAmount: CurrencyCodeAmount?,
        finalPaymentDate: String?,
        failedPaymentCount: String?
    ) {
        self.outstanding = outstanding
        self.cyclesRemaining = cyclesRemaining
        self.cyclesComplete = cyclesComplete
        self.nextBilling = nextBilling
        self.lastPaymentDate = lastPaymentDate
        self.lastPaymentAmount = lastPaymentAmount
        self.finalPaymentDate = finalPaymentDate
        self.failedPaymentCount = failedPaymentCount
    }
    
    enum CodingKeys: String, CodingKey {
        case outstanding = "outstanding_balance"
        case cyclesRemaining = "cycles_remaining"
        case cyclesComplete = "cycles_completed"
        case nextBilling = "next_billing_date"
        case lastPaymentDate = "last_payment_date"
        case lastPaymentAmount = "last_payment_amount"
        case finalPaymentDate = "final_payment_date"
        case failedPaymentCount = "failed_payment_count"
    }
}
