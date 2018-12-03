import Vapor

/// The summary of a payment made.P
public struct PaymentSummary: Content, Equatable {
    
    /// The currency and amount of the total paid or refunded through PayPal.
    public let paypal: CurrencyAmount?
    
    /// The currency and amount of the total paid or refunded through other sources.
    public let other: CurrencyAmount?
}
