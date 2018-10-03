import Vapor

/// The type of financial activity that an `Activity` model represents.
public enum ActivityType: String, Hashable, CaseIterable, Content {
    
    /// An agreement for a recurring payment for merchant-provided goods or services.
    case billingAgreement = "BILLING_AGREEMENT"
    
    /// A bill for merchant-provided goods or services.
    case invoice = "INVOICE"
    
    /// A request for money from one party to another.
    case moneyRequest = "MONEY_REQUEST"
    
    /// An approved purchase without any hold on the funds.
    case order = "ORDER"
    
    /// A movement of money from one account to another.
    case payment = "PAYMENT"
    
    /// A merchant-initiated simultaneous payment to multiple accounts.
    /// Typically a commission, rebate, reward, or general disbursement.
    case payout = "PAYOUT"
    
    /// A recurring profile.
    case recurringProfile = "RECURRING_PROFILE"
    
    /// A subscription.
    case subscription = "SUBSCRIPTION"
}
