import Vapor

public struct PaymentSummary: Content, Equatable {
    public let paypal: Amount?
    public let other: Amount?
}
